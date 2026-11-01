resource "aws_vpc" "main"{
    cidr_block = var.vpc_cidr
    tags ={
        Name = "J-T-vpc"
    }
}

resource "aws_subnet" "Public"{
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet_cidr

      map_public_ip_on_launch = true
    tags={
        Name = "Public-1"
        Type = "Public"
    }

}
resource "aws_subnet" "Private"{
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet_cidr_private
    tags={
        Name = "Private-1"
        Type = "Private"
    }

}

resource "aws_internet_gateway" "igw"{
    vpc_id= aws_vpc.main.id
    tags={
        Name = "IGW"
    }
}
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "NAT-EIP"
  }
}

resource "aws_nat_gateway" "nat" {
      allocation_id = aws_eip.nat.id
      subnet_id = aws_subnet.Public.id

       depends_on = [aws_internet_gateway.igw]
    
       tags = {
          Name = "NAT"
    }
}
resource "aws_route_table" "public"{
    vpc_id = aws_vpc.main.id
    route{
        cidr_block = var.route_table
        gateway_id = aws_internet_gateway.igw.id    

    }
    tags={
        Name = "Public-Route-Table"
    }
}
resource "aws_route_table_association" "public"{
    subnet_id = aws_subnet.Public.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private"{
    vpc_id = aws_vpc.main.id
    route{
        cidr_block = var.route_table_private
        nat_gateway_id = aws_nat_gateway.nat.id
    }
    tags={
        Name = "Private-Route-Table"
    }
}
resource "aws_route_table_association" "private"{
    subnet_id = aws_subnet.Private.id
    route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "sg"{
    name = "security"
    vpc_id = aws_vpc.main.id

    ingress{
        description = "All traffic"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.sg]
    }
      egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2"{
    ami = var.ami
    instance_type = "t2.medium"
    availability_zone      = "us-west-2a"
    subnet_id = aws_subnet.Private.id
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags={
        Name = "Dev"
    }
}
