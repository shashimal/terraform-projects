resource "aws_cloudwatch_log_group" "cloudwatch_filter_log_group" {
  name = var.log_group_name
  retention_in_days = var.log_retention_days
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${log_group_name}"
  retention_in_days = var.log_retention_days
}