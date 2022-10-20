module "service_provide_webapp" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                   = "webapp"
  ami                    = var.ami
  instance_type          = var.instance_type
  monitoring             = true
  vpc_security_group_ids = [module.webserver_sg.security_group_id]
  subnet_id              = element(module.service_provider_vpc.public_subnets, 0)
  user_data = file("install_apache.sh")
}

resource "aws_ami_from_instance" "simple_webserver" {
  name               = "simple-webserver"
  source_instance_id = module.service_provide_webapp.id
}