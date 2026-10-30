resource "aws_vpc" "main"{
    cidr_block = var.vpc_cidr
    tags ={
        Name = "J-T-vpc"
    }
}

resource "aws_subnet" "Public"{
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet_cidr
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
    vpc_id= aws.vpc.main.id
    tags={
        Name = "IGW"
    }
}

resource "aws_nat_gateway" "nat" {
    subnet_id = aws_subnet.Public.id
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
resource "aws_association" "public"{
    subnet_id = aws_subnet.public.id
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
resource "aws_association" "private"{
    subnet_id = aws_subnet.private.id
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
}

resource "aws_instance" "ec2"{
    ami = var.ami
    instance_type = "t2.medium"
    subnet_id = aws_subnet.Private.id
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags={
        Name = "Dev"
    }
}
