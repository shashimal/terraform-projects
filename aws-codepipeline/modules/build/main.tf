#data "template_file" "codebuild-iam-policy" {
#  template = file("${path.module}/codebuild-iam-policy.json")
#}

resource "aws_s3_bucket" "s3-codebuild-logging" {
  bucket = "du-codebuild-logging"
  acl    = "private"
}

resource "aws_iam_role" "codebuild-iam-role" {
  name               = "codebuild-iam-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codebuild-iam-policy" {
  role = aws_iam_role.codebuild-iam-role.name

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "*"
            ],
            "Resource": [
                "${aws_s3_bucket.s3-codebuild-logging.arn}",
                "${aws_s3_bucket.s3-codebuild-logging.arn}/*"
            ],
            "Effect": "Allow"
        },
{
            "Action": [
                "*"
            ],
           "Resource": [
                "${var.artifact_bucket_arn}",
                "${var.artifact_bucket_arn}/*"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "kms:Decrypt",
                "kms:DescribeKey",
                "kms:Encrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "kms:Decrypt",
                "kms:Encrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
POLICY
}


resource "aws_codebuild_project" "codebuild_project" {
  name         = "lambda-codebuild-project"
  service_role = aws_iam_role.codebuild-iam-role.arn
  artifacts {
    type = "CODEPIPELINE"
  }
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:5.0"
    type         = "LINUX_CONTAINER"
  }
  source {
    type = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }
}