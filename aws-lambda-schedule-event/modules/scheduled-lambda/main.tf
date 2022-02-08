resource "aws_lambda_function" "scheduler-lambda" {
  function_name    = var.function_name
  filename         = "${abspath(path.root)}/${var.filename}"
  handler          = var.handler
  source_code_hash = filebase64sha256(var.filename)
  runtime          = var.runtime
  role             = aws_iam_role.scheduler-lambda-iam-role.arn

  depends_on = [
    aws_cloudwatch_log_group.scheduler-lambda-log-group,
    aws_iam_policy_attachment.scheduler-lambda-iam-policies
  ]
}

resource "aws_iam_policy_attachment" "scheduler-lambda-iam-policies" {
  name               = "${var.function_name}-iam-policies"
  roles = [aws_iam_role.scheduler-lambda-iam-role.name]
  policy_arn = aws_iam_policy.scheduler-lambda-logging.arn
}

resource "aws_iam_role" "scheduler-lambda-iam-role" {
  name               = "${var.function_name}-iam-role"
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

resource "aws_cloudwatch_log_group" "scheduler-lambda-log-group" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 30
}

resource "aws_iam_policy" "scheduler-lambda-logging" {
  name        = "${var.function_name}-logging"
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