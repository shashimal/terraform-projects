resource "aws_cloudwatch_log_group" "employee_info" {
  name = "employee-info"
}

data "aws_cloudwatch_log_data_protection_policy_document" "log_data_protection_policy" {
  name = "employee-pii-protection-policy"
  statement {
    sid = "Audit"

    data_identifiers = [
      "arn:aws:dataprotection::aws:data-identifier/EmailAddress",
      "arn:aws:dataprotection::aws:data-identifier/DriversLicense-US",
    ]

    operation {
      audit {
        findings_destination {
          cloudwatch_logs {
            log_group = aws_cloudwatch_log_group.employee_info.name
          }
        }
      }
    }
  }
  statement {
    sid = "Deidentify"

    data_identifiers = [
      "arn:aws:dataprotection::aws:data-identifier/EmailAddress",
      "arn:aws:dataprotection::aws:data-identifier/DriversLicense-US",
    ]

    operation {
      deidentify {
        mask_config {}
      }
    }
  }
}