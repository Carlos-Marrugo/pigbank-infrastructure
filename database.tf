resource "aws_dynamodb_table" "user_table" {
  name         = "pigbank-users"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "uuid"     
  range_key    = "document"  

  attribute {
    name = "uuid"
    type = "S" 
  }

  attribute {
    name = "document"
    type = "S"
  }

  attribute {
    name = "email"
    type = "S"
  }

  global_secondary_index {
    name            = "EmailIndex"
    hash_key        = "email"
    projection_type = "ALL"
  }
}