module "service_provider_app" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                   = "service_provider_app"
  ami                    = aws_ami_from_instance.simple_webserver.id
  instance_type          = var.instance_type
  monitoring             = true
  vpc_security_group_ids = [module.webserver_sg.security_group_id]
  subnet_id              = element(module.service_provider_vpc.private_subnets, 0)
}