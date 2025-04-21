resource "aws_sns_topic" "alerts" {
  name = "high-cpu-alerts"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = "your-email@example.com"
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "high-cpu-usage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "This alarm triggers if CPU > 70%"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  dimensions = {
    InstanceId = "your-instance-id"
  }
}
