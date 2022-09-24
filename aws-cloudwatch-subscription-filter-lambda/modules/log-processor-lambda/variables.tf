variable "function_name" {
  type = string
}

variable "function_handler" {
  type = string
}

variable "source_path" {
  type = string
}

variable "runtime" {
  type = string
  default = "nodejs12.x"
}

variable "lambda_cloudwatch_log_group" {
}