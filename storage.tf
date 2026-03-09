resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "user_avatars" {
  bucket = "pigbank-user-avatars-${random_id.bucket_suffix.hex}"
}