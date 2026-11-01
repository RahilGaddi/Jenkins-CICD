# Jenkins CI/CD Automation with Terraform and AWS Lambda

This repository contains two hands-on projects demonstrating Jenkins CI/CD automation, GitHub webhook integration, infrastructure provisioning with Terraform, and AWS Lambda deployment for EC2 health monitoring.

## Project 1: Jenkins Basic CI/CD with Terraform

**Directory:** `Jenkins-Basic-CICD/`

This project demonstrates automated AWS infrastructure provisioning using Terraform and Jenkins CI/CD pipelines, including infrastructure configuration, validation, and deployment.

### Technologies Used

- Jenkins
- Terraform
- AWS
- Git
- GitHub

### Project Structure

| File | Description |
|---|---|
| `Jenkinsfile` | Defines the Jenkins pipeline stages |
| `backend.tf` | Configures the Terraform state backend |
| `main.tf` | Defines AWS infrastructure resources |
| `providers.tf` | Configures Terraform providers |
| `variables.tf` | Defines input variables |
| `terraform.tfvars` | Provides variable values |
| `output.tf` | Defines Terraform outputs |

### Workflow

1. Jenkins retrieves the source code from GitHub.
2. Terraform initializes the working directory.
3. Terraform validates the configuration.
4. Terraform plans the infrastructure changes.
5. Terraform applies the configuration to provision AWS resources.

The actual workflow depends on the stages defined in the Jenkinsfile.

## Project 2: Jenkins Master-Agent CI/CD with AWS Lambda

**Directory:** `Master-Slave-CICD/`

This project demonstrates Jenkins controller-agent pipeline execution, GitHub webhook integration for automated builds, and CI/CD deployment of an AWS Lambda function for EC2 instance health monitoring.

### Technologies Used

- Jenkins Controller and Agent
- Jenkins CI/CD Pipeline
- GitHub Webhooks
- AWS IAM
- AWS Lambda
- Amazon EC2
- AWS CLI
- Python and Boto3
- Git and GitHub

### Project Structure

| File | Description |
|---|---|
| `Jenkinsfile` | Defines the CI/CD pipeline |
| `lambda/lambda_function.py` | Contains the EC2 health-check logic |

### Workflow

1. Jenkins retrieves the source code from GitHub.
2. The pipeline validates the Python code.
3. The Lambda source code is packaged into a ZIP file.
4. The pipeline creates or updates the Lambda function, depending on the configured deployment logic.
5. The Lambda function checks the EC2 instance state and system status checks.
6. The health-check result is returned, and execution logs are sent to CloudWatch Logs.

The deployment requires appropriate AWS IAM permissions and a Lambda execution role.

## Repository Structure

```text
Jenkins-Terraform-CICD/
|
|-- Jenkins-Basic-CICD/
|   |-- Jenkinsfile
|   |-- backend.tf
|   |-- main.tf
|   |-- output.tf
|   |-- providers.tf
|   |-- terraform.tfvars
|   |-- variables.tf
|
|-- Master-Slave-CICD/
|   |-- Jenkinsfile
|   |-- lambda/
|       |-- lambda_function.py
|
|-- .gitignore
|-- README.md
```

## Prerequisites

- AWS account with appropriate IAM permissions
- Jenkins controller and configured agent
- Git and GitHub repository
- Terraform installed on the Jenkins agent for infrastructure provisioning
- AWS CLI configured with appropriate AWS access
- Python and Boto3 for Lambda code validation and deployment packaging
- ZIP utility for packaging Lambda deployment files
- GitHub webhook configured to trigger Jenkins builds

## Security

- Never commit AWS access keys, secret keys, or other credentials to GitHub.
- Use IAM roles and follow the principle of least privilege.
- Store sensitive credentials securely and avoid hardcoding them in pipeline files.
- Do not commit passwords, private keys, or confidential information.
- Keep sensitive values out of version-controlled Terraform variable files.
- Review Terraform plans before applying infrastructure changes.
- Grant Jenkins only the AWS permissions required for deployment.
- Secure Jenkins agents and restrict access to build logs and configuration files.

## Learning Outcomes

- Jenkins CI/CD pipeline configuration and automation
- AWS infrastructure provisioning using Terraform
- Jenkins controller and agent configuration
- GitHub webhook integration for automated pipeline triggers
- AWS Lambda deployment and configuration
- IAM roles and permissions for AWS services
- EC2 instance health monitoring using AWS Lambda
- Git-based version control and CI/CD integration

## Author

**Rahil Gaddi**

GitHub: https://github.com/RahilGaddi

LinkedIn: https://www.linkedin.com/in/rahilgaddi/
