
import json
import logging
import os
from datetime import datetime, timezone

import boto3

logger = logging.getLogger()
logger.setLevel(logging.INFO)

ec2 = boto3.client("ec2")

INSTANCE_ID = os.environ["INSTANCE_ID"]


def lambda_handler(event, context):
    result = {
        "event": "ec2_health_check",
        "instance_id": INSTANCE_ID,
        "checked_at": datetime.now(timezone.utc).isoformat(),
        "request_id": context.aws_request_id,
    }

    try:
        response = ec2.describe_instances(
            InstanceIds=[INSTANCE_ID]
        )

        instances = [
            instance
            for reservation in response["Reservations"]
            for instance in reservation["Instances"]
        ]

        if not instances:
            result.update({
                "health": "UNKNOWN",
                "reason": "Instance not found",
            })
            logger.warning(json.dumps(result))
            return result

        state = instances[0]["State"]["Name"]
        result["instance_state"] = state

        if state != "running":
            result.update({
                "health": "UNHEALTHY",
                "reason": f"Instance state is {state}",
            })
            logger.error(json.dumps(result))
            return result

        response = ec2.describe_instance_status(
            InstanceIds=[INSTANCE_ID],
            IncludeAllInstances=True,
        )

        statuses = response.get("InstanceStatuses", [])

        if not statuses:
            result.update({
                "health": "UNKNOWN",
                "reason": "Status checks not yet available",
            })
            logger.warning(json.dumps(result))
            return result

        status = statuses[0]
        system = status["SystemStatus"]["Status"]
        instance = status["InstanceStatus"]["Status"]

        result["system_status_check"] = system
        result["instance_status_check"] = instance

        if system == "ok" and instance == "ok":
            result.update({
                "health": "HEALTHY",
                "reason": "EC2 status checks passed",
            })
            logger.info(json.dumps(result))
        else:
            result.update({
                "health": "UNHEALTHY",
                "reason": "One or more EC2 status checks failed",
            })
            logger.error(json.dumps(result))

        return result

    except Exception:
        logger.exception("EC2 health check failed")
        raise
