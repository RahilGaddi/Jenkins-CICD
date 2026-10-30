output "vpc_id"{
    value = aws_vpc.main.id

}

output "aws_instance_id"{
    value = aws_instance.ec2.id
}