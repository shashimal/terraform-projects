resource "aws_cloudwatch_event_rule" "schedule-event" {
  schedule_expression = var.cron_expression
  is_enabled = false
}

resource "aws_cloudwatch_event_target" "schedule-event-target" {
  rule = aws_cloudwatch_event_rule.schedule-event.name
  arn  = var.scheduler_lambda_arn
}

resource "aws_lambda_permission" "event-bridge-lambda-permission" {
  action        = "lambda:InvokeFunction"
  function_name = var.scheduler_lambda_function
  principal     = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.schedule-event.arn
}