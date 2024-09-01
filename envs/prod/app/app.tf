# VPC モジュールの呼び出し
module "vpc" {
  source = "../../../modules/vpc"

  gateway_id = module.internet_gateway.internet_gateway_id
  subnet_id = module.subnet.public_subnet_a_id
}

# サブネット モジュールの呼び出し
module "subnet" {
  source = "../../../modules/subnet"

  vpc_id = module.vpc.vpc_id
}

# インターネットゲートウェイ モジュールの呼び出し
module "internet_gateway" {
  source = "../../../modules/internet_gateway"

  vpc_id = module.vpc.vpc_id
}

# セキュリティグループ モジュールの呼び出し
module "security_group" {
  source = "../../../modules/security_group"

  vpc_id = module.vpc.vpc_id
}

# ALB モジュールの呼び出し
module "alb" {
  source = "../../../modules/alb"
  
  vpc_id          = module.vpc.vpc_id
  subnets      = [module.subnet.public_subnet_a_id]
  security_groups = [module.security_group.app_sg_id]

  target_id = module.ec2.instance_id
}

# DB モジュールの呼び出し
module "db" {
  source = "../../../modules/db"
}

# EC2 モジュールの呼び出し
module "ec2" {
  source = "../../../modules/ec2"

  subnet_id = module.subnet.public_subnet_a_id
  # vpc_security_group_id = module.security_group.security_group_app_id
  security_group_ids = [ module.security_group.security_group_app_id ]
}
