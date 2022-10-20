module "service_consumer_bastion_host" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                   = var.bastion_host_name
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  monitoring             = var.monitoring
  vpc_security_group_ids = [module.service_consumer_bastion_host_sg.security_group_id]
  subnet_id              = element(module.service_consumer_vpc.public_subnets, 0)
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  tags                   = var.tags
}

module "service_consumer_private_server" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                   = "private_server"
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  monitoring             = var.monitoring
  vpc_security_group_ids = [module.service_consumer_bastion_host_sg.security_group_id]
  subnet_id              = element(module.service_consumer_vpc.private_subnets, 0)
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  tags                   = var.tags
}