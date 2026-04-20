module "vpc" {
    source = "./module/vpc"
}

module "ec2" {
    source = "./module/ec2"
    vpc_id = module.vpc.vpc_id
    subnet_id = module.vpc.public_subnet_id
    instance_type = var.instance_type
}

module "rds" {
    source = "./module/rds"
    vpc_id = module.vpc.vpc_id
    private_subnet_ids = module.vpc.private_subnet_ids
    db_username = var.db_username
    db_password = var.db_password
}