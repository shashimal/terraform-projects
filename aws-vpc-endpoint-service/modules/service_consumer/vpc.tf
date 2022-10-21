module "service_consumer_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.service_consumer_vpc_name
  cidr = var.service_consumer_vpc_cidr

  azs             = var.service_consumer_az
  private_subnets = var.service_consumer_private_subnets
  public_subnets  = var.service_consumer_public_subnets

  enable_nat_gateway   = var.enable_nat_gateway
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = var.tags
}

resource "aws_vpc_endpoint" "vpc_endpoint" {
  service_name = var.vpc_endpoint_service_name
  vpc_id       = module.service_consumer_vpc.vpc_id
  vpc_endpoint_type = "Interface"
  security_group_ids = [module.service_consumer_vpc_endpoint_sg.security_group_id]
}