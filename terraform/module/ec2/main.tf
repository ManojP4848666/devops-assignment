#IAM ROLE FOR SSM

resource "aws_iam_role" "ssm_role" {
    name = "ssm_role"
    assume_role_policy = jsonencode ({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

#ATTACH SSM POLICY
resource "aws_iam_role_policy_attachment" "ssm_policy" {
    role = aws_iam_role.ssm_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#INSTANCE PROFILE

resource "aws_iam_instance_profile" "ssm_profile" {
    name = "ssm-instance-profile"
    role = aws_iam_role.ssm_role.name
}

#SECURITY GROUP (NO SSH HERE)
resource "aws_security_group" "ec2_sg" {
    vpc_id = var.vpc_id
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    #SSH
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#EC2MACHINE INSTANCE CREATION
resource "aws_instance" "application" {
    ami = "ami-0f58b397bc5c1f2e8"
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    vpc_security_group_ids = [aws_security_group.ec2_sg.id]
    iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
    key_name = "manojsshkey"
    tags = {
        Name = "manoj-ssm-ec2machines"
    }
}