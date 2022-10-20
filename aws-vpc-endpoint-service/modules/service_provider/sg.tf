module "webserver_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name                = "webserver-sg"
  description         = "webserver-sg"
  vpc_id              = module.service_provider_vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp"]
  egress_rules        = ["all-all"]
}