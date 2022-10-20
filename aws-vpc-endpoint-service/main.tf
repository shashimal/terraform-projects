module "service_provider" {
  source = "./modules/service_provider"

  service_provider_vpc_name        = "service-provider-vpc"
  service_provider_vpc_cidr        = "20.0.0.0/16"
  service_provider_private_subnets = ["20.0.1.0/24", "20.0.2.0/24"]
  service_provider_public_subnets  = ["20.0.101.0/24", "20.0.102.0/24"]
  service_provider_az              = ["us-east-1a", "us-east-1b"]
  tags                             = {
    Name        = "Service Provider VPC"
    Environment = "Dev"
  }
  ami = "ami-026b57f3c383c2eec"
}

module "service_consumer" {
  source = "./modules/service_consumer"

  #VPC
  service_consumer_vpc_name        = "service-consumer-vpc"
  service_consumer_vpc_cidr        = "10.0.0.0/16"
  service_consumer_private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  service_consumer_public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  service_consumer_az              = ["us-east-1a", "us-east-1b"]

  #Bastion Host
  bastion_host_name = "service-consumer-bastion-host"
  ami           = "ami-026b57f3c383c2eec"
  instance_type = "t2.micro"
  key_name      = "US-Key"
  bastion_host_sg_ingress_cidr = ["0.0.0.0/0"]
  bastion_host_sg_ingress_rules = ["ssh-tcp"]

  #Private Server
  private_server_name = "service-consumer-private-server"
  private_server_sg_ingress_cidr  = ["10.0.101.0/24", "10.0.102.0/24"]
  private_server_sg_ingress_rules = ["ssh-tcp"]
}