resource "aws_lambda_function" "cloudwatch_filter_destination_lambda" {
  function_name = var.function_name
  role          = aws_iam_role.lambda_iam_role.arn
  filename         = var.source_path
  handler          = var.function_handler
  source_code_hash = filebase64sha256(var.source_path)
  runtime          = var.runtime

  depends_on = [
    var.lambda_cloudwatch_log_group,
    aws_iam_policy_attachment.lambda-iam-policy-attachment
  ]
}

resource "aws_iam_role" "lambda_iam_role" {
  name               = "${var.function_name}-lambda-iam-role"
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

resource "aws_iam_policy" "lambda_iam_policy" {
  name        = "${var.function_name}-lambda-iam-policy"
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

resource "aws_iam_policy_attachment" "lambda-iam-policy-attachment" {
  name               = "${var.function_name}-lambda-iam-policy-attachment"
  roles = [aws_iam_role.lambda_iam_role.name]
  policy_arn = aws_iam_policy.lambda_iam_policy.arn
}

resource "aws_lambda_permission" "cloudwatch-filter-lambda-permission" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cloudwatch_filter_destination_lambda.function_name
  principal     = "logs.us-east-1.amazonaws.com"
}