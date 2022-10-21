module "service_consumer_bastion_host_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name                = "${var.bastion_host_name}-sg"
  description         = "${var.bastion_host_name}-sg"
  vpc_id              = module.service_consumer_vpc.vpc_id
  ingress_cidr_blocks = var.bastion_host_sg_ingress_cidr
  ingress_rules       = var.bastion_host_sg_ingress_rules
  egress_rules        = ["all-all"]
}

module "service_consumer_private_server_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name                = "${var.private_server_name}-sg"
  description         = "${var.private_server_name}-sg"
  vpc_id              = module.service_consumer_vpc.vpc_id
  ingress_cidr_blocks = var.private_server_sg_ingress_cidr
  ingress_rules       = var.private_server_sg_ingress_rules
  egress_rules        = ["all-all"]
}

module "service_consumer_vpc_endpoint_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name                = "vpc-endpoint-sg"
  description         = "vpc-endpoint-sg"
  vpc_id              = module.service_consumer_vpc.vpc_id
  ingress_cidr_blocks = var.private_server_sg_ingress_cidr
  ingress_rules       = ["http-80-tcp"]
  egress_rules        = ["all-all"]
}