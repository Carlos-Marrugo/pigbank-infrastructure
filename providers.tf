provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test" # Credenciales ficticias para el simulador
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    dynamodb       = "http://localhost:4566"
    s3             = "http://s3.localhost.localstack.cloud:4566"
    sqs            = "http://localhost:4566"
    secretsmanager = "http://localhost:4566"
    lambda         = "http://localhost:4566"
    iam            = "http://localhost:4566"
    apigateway     = "http://localhost:4566"
  }
}