variable "service_provider_vpc_name" {
  type = string
}

variable "service_provider_vpc_cidr" {
  type = string
}

variable "service_provider_az" {
  type = list(string)
}

variable "service_provider_private_subnets" {
  type = list(string)
}

variable "service_provider_public_subnets" {
  type = list(string)
}

variable "enable_nat_gateway" {
  type = bool
  default = false
}

variable "enable_dns_hostnames" {
  type = bool
  default = true
}

variable "enable_dns_support" {
  type = bool
  default = true
}

variable "tags" {
  type = object({})
  default = {}
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}