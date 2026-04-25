resource "aws_sqs_queue" "card_request_queue" {
  name = "create-request-card-sqs"

  visibility_timeout_seconds = 30
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 10

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.card_request_dlq.arn
    maxReceiveCount     = 3
  })
}

resource "aws_sqs_queue" "notification_email_queue" {
  name = "notification-email-sqs"

  visibility_timeout_seconds = 30
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 10

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.notification_email_dlq.arn
    maxReceiveCount     = 3
  })
}

resource "aws_sqs_queue" "card_request_dlq" {
  name = "create-request-card-sqs-dlq"

  message_retention_seconds = 1209600  # 14 días
}

resource "aws_sqs_queue" "notification_email_dlq" {
  name = "notification-email-sqs-dlq"

  message_retention_seconds = 1209600
}

output "card_request_queue_url" {
  value = aws_sqs_queue.card_request_queue.url
}

output "notification_email_queue_url" {
  value = aws_sqs_queue.notification_email_queue.url
}
