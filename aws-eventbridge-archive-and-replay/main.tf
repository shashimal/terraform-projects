module "eventbridge" {
  source = "terraform-aws-modules/eventbridge/aws"

  bus_name = "customer-order-bus"


  # EventBridge filters events using below rule
  rules = {
    customer-order-events = {
      description   = "Customer Order Events"
      event_pattern = jsonencode({
        "source" : ["com.duleendra.orderservice"]
         "detail-type" : ["Customer Order"]
      })
    }
  }

  # EventBridge sends the matched events to a CloudWatch loggroup
  targets = {
    customer-order-events = [
      {
        name = "customer-order-events-logs"
        arn  = aws_cloudwatch_log_group.cloudwatch_logs.arn
      }
    ]
  }

  # Enable events archive for this event bus
  create_archives = true

  archives = {
    "customer-order-events-archive" = {
      description    = "Customer order events archive "
      retention_days = 1
      event_pattern  = jsonencode({
        "source" : ["com.duleendra.orderservice"]
        "detail-type" : ["Customer Order"]
      })
    }
  }

  tags = {
    Name = "customer-order-bus"
  }
}

resource "aws_cloudwatch_log_group" "cloudwatch_logs" {
  name              = "/aws/events/customer-order-events-logs"
  retention_in_days = 30
}


