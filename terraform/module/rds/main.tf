#SECURITY GROUP FOR RDS
resource "aws_security_group" "rds_sg" {
    vpc_id = var.vpc_id
    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = ["10.10.0.0/16"] #ALLOW FROM VPC ONLY
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#DB SUBNET GROUP
resource "aws_db_subnet_group" "rds_subnet_group" {
name = "rds_subnet_group"
subnet_ids = var.private_subnet_ids
}


#RDS INSTANCE
resource "aws_db_instance" "postgres" {
    identifier = "manojdb"
    engine = "postgres"
    instance_class = "db.t3.micro"
    allocated_storage = 20
    username = var.db_username
    password = var.db_password
    db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
    vpc_security_group_ids = [aws_security_group.rds_sg.id]
    skip_final_snapshot = true
    publicly_accessible = false
}