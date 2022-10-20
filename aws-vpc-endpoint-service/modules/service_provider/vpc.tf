module "service_provider_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.service_provider_vpc_name
  cidr = var.service_provider_vpc_cidr

  azs             = var.service_provider_az
  private_subnets = var.service_provider_private_subnets
  public_subnets  = var.service_provider_public_subnets

  enable_nat_gateway   = var.enable_nat_gateway
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = var.tags
}

resource "aws_vpc_endpoint_service" "service_provider_endpoint_service" {
  acceptance_required = false
  network_load_balancer_arns = [module.nlb.lb_arn]
}