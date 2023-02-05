module "vpc_a" {
  source = "terraform-aws-modules/vpc/aws"

  name = "VPC-A"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway   = false
  enable_dns_hostnames = true
  enable_dns_support   = true
}

module "vpc_b" {
  source = "terraform-aws-modules/vpc/aws"

  name = "VPC-B"
  cidr = "20.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["20.0.1.0/24", "20.0.2.0/24"]
  public_subnets  = ["20.0.101.0/24", "20.0.102.0/24"]

  enable_nat_gateway   = false
  enable_dns_hostnames = true
  enable_dns_support   = true
}
