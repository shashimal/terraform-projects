provider "aws" {
  region = "us-east-1"
}

module "scheduled-lambda" {
  function_name = "scheduler-lambda"
  source = "./modules/scheduled-lambda"
  filename = "src/scheduler.zip"
  handler = "scheduler.handler"
  runtime = "nodejs12.x"
}

module "schedule-event" {
  source = "./modules/scheduler"
  cron_expression           = "cron(0/1 * * * ? *)"
  scheduler_lambda_arn      = module.scheduled-lambda.scheduler-lambda_arn
  scheduler_lambda_function = module.scheduled-lambda.scheduler-lambda_function_name
}

