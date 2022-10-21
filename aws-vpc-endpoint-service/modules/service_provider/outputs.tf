output "service_provider_vpc_id" {
  value = module.service_provider_vpc.vpc_id
}

output "service_provider_ami" {
  value = aws_ami_from_instance.simple_webserver.id
}

output "vpc_endpoint_service_name" {
  value = aws_vpc_endpoint_service.service_provider_endpoint_service.service_name
}