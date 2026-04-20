variable "region" {
description = "AWS REGION MENTIONED HERE"
default = "ap-south-1"
}

variable "assignment_name" {
default = "devops-assignment"
}

variable "instance_type" {
description = "EC2MACHINE INSTANCE TYPE"
default = "t3.micro"
}

variable "db_username" {
    default = "postgres"
}

variable "db_password" {
    default = "postgres123"
}