resource "aws_ec2_transit_gateway" "tgw" {
 description = "TGW-Example"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_vpc_a_attachment" {
 subnet_ids         = module.vpc_a.private_subnets
 transit_gateway_id = aws_ec2_transit_gateway.tgw.id
 vpc_id             = module.vpc_a.vpc_id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_vpc_b_attachment" {
 subnet_ids         = module.vpc_b.private_subnets
 transit_gateway_id = aws_ec2_transit_gateway.tgw.id
 vpc_id             = module.vpc_b.vpc_id
}