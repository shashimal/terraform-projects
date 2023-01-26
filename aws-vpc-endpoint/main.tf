resource "aws_vpc_endpoint" "s3_endpoint" {
  service_name = "com.amazonaws.us-east-1.s3"
  vpc_id       = module.vpc.vpc_id
  vpc_endpoint_type = "Gateway"
  route_table_ids = module.vpc.private_route_table_ids
  policy = data.aws_iam_policy_document.s3_gateway_endpoint_policy.json

}

resource "aws_vpc_endpoint" "sqs_endpoint" {
  service_name = "com.amazonaws.us-east-1.sqs"
  vpc_id       = module.vpc.vpc_id
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids = module.vpc.private_subnets
  security_group_ids = [aws_security_group.interface_sg.id]
}

data "aws_iam_policy_document" "s3_gateway_endpoint_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::du-emp-data",
      "arn:aws:s3:::du-emp-data/*"
    ]
  }
}
