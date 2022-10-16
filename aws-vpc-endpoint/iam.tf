data "aws_iam_policy_document" "ec2_trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "s3_access_policy_document" {
  statement {
    sid     = "SidS3"
    effect  = "Allow"
    actions = [
      "s3:*"
    ]
    resources = ["*"]
  }
  statement {
    sid     = "SidSQS"
    effect  = "Allow"
    actions = [
      "sqs:*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "ec2_instance_role" {
  assume_role_policy = data.aws_iam_policy_document.ec2_trust_policy.json
  name = "EC2-S3-Access-Role"
}

resource "aws_iam_role_policy" "EC2_iam_policy" {
  name = "EC2-Access-Policy"
  policy = data.aws_iam_policy_document.s3_access_policy_document.json
  role = aws_iam_role.ec2_instance_role.id
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name="ec2-profile"
  role = aws_iam_role.ec2_instance_role.name
}