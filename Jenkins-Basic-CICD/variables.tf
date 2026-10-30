variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type = string
    default = ""
}

variable "subnet_cidr"{
    description = "CIDR block for the subnet public"
    type = string
    default = ""
}


variable "subnet_cidr_private"{
    description = "CIDR block for the subnet private"
    type = string
    default = ""
}

variable "route_table"{
    description = "Route table for the subnet public"
    type = string
    default = ""
}

variable "route_table_private"{
    description = "Route table for the subnet private"
    type = string
    default = ""
}

variable "sg"{
    description = "Security group for the instance"
    type = string
    default = ""
}

variable "ami"{
    description = "AMI for the instance"
    type = string
    default = ""
}