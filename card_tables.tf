resource "aws_dynamodb_table" "cards_table" {
  name         = "pigbank-cards"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "card_id"

  attribute {
    name = "card_id"
    type = "S"
  }

  attribute {
    name = "user_id"
    type = "S"
  }

  attribute {
    name = "card_type"
    type = "S"
  }

  global_secondary_index {
    name            = "UserIndex"
    hash_key        = "user_id"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "TypeIndex"
    hash_key        = "card_type"
    projection_type = "ALL"
  }
}

resource "aws_dynamodb_table" "transactions_table" {
  name         = "pigbank-transactions"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "transaction_id"
  range_key    = "created_at"

  attribute {
    name = "transaction_id"
    type = "S"
  }

  attribute {
    name = "created_at"
    type = "S"
  }

  attribute {
    name = "user_id"
    type = "S"
  }

  attribute {
    name = "card_id"
    type = "S"
  }

  global_secondary_index {
    name            = "UserIndex"
    hash_key        = "user_id"
    range_key       = "created_at"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "CardIndex"
    hash_key        = "card_id"
    range_key       = "created_at"
    projection_type = "ALL"
  }
}

output "cards_table_name" {
  value = aws_dynamodb_table.cards_table.name
}

output "transactions_table_name" {
  value = aws_dynamodb_table.transactions_table.name
}
