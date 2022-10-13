resource "aws_vpc_endpoint" "s3_endpoint" {
  service_name = "com.amazonaws.us-east-1.s3"
  vpc_id       = "vpc-b9dbb0c4"
  vpc_endpoint_type = "Gateway"
  route_table_ids = ["rtb-01e01170"]
}