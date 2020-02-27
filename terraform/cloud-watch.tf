resource "aws_cloudwatch_event_rule" "ssm" {
  name        = "sessoion-manager-notification"
  description = "session manager notification"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.ssm"
  ],
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "detail": {
    "eventSource": [
      "ssm.amazonaws.com"
    ],
    "eventName": [
      "StartSession",
      "TerminateSession"
    ]
  }
}
PATTERN
}
