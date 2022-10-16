resource "aws_vpc_endpoint" "s3_endpoint" {
  service_name = "com.amazonaws.us-east-1.s3"
  vpc_id       = module.vpc.vpc_id
  vpc_endpoint_type = "Gateway"
  route_table_ids = module.vpc.private_route_table_ids
}