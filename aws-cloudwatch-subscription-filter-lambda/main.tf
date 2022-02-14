provider "aws" {
  region = "us-east-1"
}

resource "aws_cloudwatch_log_group" "customer-service-logs" {
  name = "customer-service-logs"
}

resource "aws_lambda_function" "customer-service-lambda" {
  function_name = "customer-service"
  role          = aws_iam_role.customer-service-lambda-iam-role.arn
  filename         = "${abspath(path.root)}/lambda-function/log.zip"
  handler          = "log.handler"
  source_code_hash = filebase64sha256("lambda-function/log.zip")
  runtime          = "nodejs12.x"

  depends_on = [
    aws_cloudwatch_log_group.customer-service-lambda-log-group,
    aws_iam_policy_attachment.customer-service-lambda-iam-policy-attachment
  ]
}

resource "aws_cloudwatch_log_subscription_filter" "customer-service-subscription-filter" {
  destination_arn = aws_lambda_function.customer-service-lambda.arn
  filter_pattern  = "?ERROR ?error ?500 ?404"
  log_group_name  = aws_cloudwatch_log_group.customer-service-logs.name
  name            = "customer-service-subscription-filter"
}


resource "aws_iam_role" "customer-service-lambda-iam-role" {
  name               = "customer-service-lambda-iam-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "customer-service-lambda-iam-policy" {
  name        = "customer-service-lambda-iam-policy"
  description = "IAM policy for logging from a lambda"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "customer-service-lambda-iam-policy-attachment" {
  name               = "customer-service-lambda-iam-policy-attachment"
  roles = [aws_iam_role.customer-service-lambda-iam-role.name]
  policy_arn = aws_iam_policy.customer-service-lambda-iam-policy.arn
}

resource "aws_cloudwatch_log_group" "customer-service-lambda-log-group" {
  name              = "/aws/lambda/customer-service"
  retention_in_days = 30
}

resource "aws_lambda_permission" "customer-service-subscription-filter-lambda-permission" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.customer-service-lambda.function_name
  principal     = "logs.us-east-1.amazonaws.com"
}