resource "aws_iam_role" "ec2_instance_role" {
  name = "ec2-instance-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_trust_policy_document.json
}

resource "aws_iam_role_policy" "ec2_instance_role_policy" {
  policy = data.aws_iam_policy_document.ec2_iam_policy_document.json
  role   = aws_iam_role.ec2_instance_role.id
}

data "aws_iam_policy_document" "ec2_trust_policy_document" {
    statement {
      actions = ["sts:AssumeRole"]
      principals {
        type        = "Service"
        identifiers = ["ec2.amazonaws.com"]
      }
    }
}

data "aws_iam_policy_document" "ec2_iam_policy_document" {
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
      "sqs:*",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name="ec2-instance-profile"
  role = aws_iam_role.ec2_instance_role.name
}
