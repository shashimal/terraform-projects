provider "aws" {
  region = "us-east-1"
}

module "cloudwatch_filter_log_group" {
  source = "./modules/cloudwatch-log-group"
  log_group_name =var.service_name
  log_retention_days = var.log_retention_days
}

module "cloudwatch_log_processor" {
  source = "./modules/log-processor-lambda"
  function_handler            = "log.handler"
  function_name               = "cloudwatch_log_processor"
  lambda_cloudwatch_log_group = module.cloudwatch_filter_log_group.lambda_log_group
  source_path                 = "lambda-function/log.zip"
}
