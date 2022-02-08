variable "cron_expression" {
  description = "Cron Expression"
  type = string
}
variable "scheduler_lambda_arn" {
  description = "Scheduler lambda expression"
  type = string
}

variable "scheduler_lambda_function" {
  type = string
}

