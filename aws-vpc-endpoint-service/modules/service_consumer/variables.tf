#VPC
variable "service_consumer_vpc_name" {
  type = string
}

variable "service_consumer_vpc_cidr" {
  type = string
}

variable "service_consumer_az" {
  type = list(string)
}

variable "service_consumer_private_subnets" {
  type = list(string)
}

variable "service_consumer_public_subnets" {
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

#Bastion Host
variable "bastion_host_name" {
  type = string
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
}

variable "monitoring" {
  type = bool
  default = false
}

variable "bastion_host_sg_ingress_rules" {
  type = list(string)
}

variable "bastion_host_sg_ingress_cidr" {
  type = list(string)
}

variable "private_server_name" {
  type = string
}

variable "private_server_sg_ingress_cidr" {
  type = list(string)
}

variable "private_server_sg_ingress_rules" {
  type = list(string)
}

variable "vpc_endpoint_service_name" {
  type = string
}