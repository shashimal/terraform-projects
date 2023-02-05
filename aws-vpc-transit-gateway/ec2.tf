module "service_consumer_bastion_host_vpc_a" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                   = "bastion-host"
  ami                    = "ami-026b57f3c383c2eec"
  instance_type          = "t2.micro"
  key_name               = "US-Key"
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  subnet_id              = element(module.vpc_a.public_subnets, 0)
}

module "private_instance_vpc_a" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                   = "Private-Instance-VPC-A"
  ami                    = "ami-026b57f3c383c2eec"
  instance_type          = "t2.micro"
  key_name               = "US-Key"
  vpc_security_group_ids = [aws_security_group.private_instance_sg.id]
  subnet_id              = element(module.vpc_a.private_subnets, 0)
}

module "private_instance_vpc_b" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                   = "Private-Instance-VPC-B"
  ami                    = "ami-026b57f3c383c2eec"
  instance_type          = "t2.micro"
  key_name               = "US-Key"
  vpc_security_group_ids = [aws_security_group.private_instance_sg.id]
  subnet_id              = element(module.vpc_a.private_subnets, 0)
}


resource "aws_security_group" "bastion_sg" {
  vpc_id = module.vpc_a.vpc_id
  name = "bastion-sg"
  description = "bastion-sg"

  ingress {
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private_instance_sg" {
  vpc_id = module.vpc_a.vpc_id
  name = "private-instance-sg"
  description = "private-instance-sg"

  ingress {
    from_port = -1
    protocol  = "ICMP"
    to_port   = -1
    cidr_blocks =module.vpc_a.public_subnets_cidr_blocks
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}