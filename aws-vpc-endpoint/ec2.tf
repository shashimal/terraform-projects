module "public_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "public-instance"

  ami                    = "ami-026b57f3c383c2eec"
  instance_type          = "t2.micro"
  key_name               = "US-Key"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  subnet_id              = element(module.vpc.public_subnets, 0)

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "private_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "private-instance"

  ami                    = "ami-026b57f3c383c2eec"
  instance_type          = "t2.micro"
  key_name               = "US-Key"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  subnet_id              = element(module.vpc.private_subnets, 0)
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}