resource "random_id" "reports_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "reports_bucket" {
  bucket = "pigbank-reports-${random_id.reports_suffix.hex}"
}

resource "random_id" "templates_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "email_templates_bucket" {
  bucket = "pigbank-email-templates-${random_id.templates_suffix.hex}"
}

output "reports_bucket_name" {
  value = aws_s3_bucket.reports_bucket.bucket
}

output "email_templates_bucket_name" {
  value = aws_s3_bucket.email_templates_bucket.bucket
}
