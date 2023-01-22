resource "aws_cloudwatch_log_group" "employee_info" {
  name = "employee-info"
}

resource "aws_cloudwatch_log_group" "employee_info_audit" {
  name = "employee-info-audit"
}

resource "aws_s3_bucket" "pii_audit_bucket" {
}

data "aws_cloudwatch_log_data_protection_policy_document" "log_data_protection_policy_document" {
  name = "employee-pii-protection-policy"
  statement {
    sid = "Audit"

    data_identifiers = [
      "arn:aws:dataprotection::aws:data-identifier/DateOfBirth",
      "arn:aws:dataprotection::aws:data-identifier/EmailAddress"
    ]

    operation {
      audit {
        findings_destination {
          s3 {
            bucket = aws_s3_bucket.pii_audit_bucket.bucket
          }
        }
      }
    }
  }
  statement {
    sid = "Deidentify"

    data_identifiers = [
      "arn:aws:dataprotection::aws:data-identifier/DateOfBirth",
      "arn:aws:dataprotection::aws:data-identifier/EmailAddress"
    ]

    operation {
      deidentify {
        mask_config {}
      }
    }
  }
}

resource "aws_cloudwatch_log_data_protection_policy" "data_protection_policy" {
  log_group_name  = aws_cloudwatch_log_group.employee_info.name
  policy_document = data.aws_cloudwatch_log_data_protection_policy_document.log_data_protection_policy_document.json
}