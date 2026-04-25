# Pig Bank - Infrastructure as Code

## Architecture Overview

Terraform-based AWS infrastructure for Pig Bank digital banking platform, fully compatible with LocalStack for local development.

---

## Tech Stack

* Terraform
* AWS (DynamoDB, S3, SQS)
* Docker + LocalStack

---

## Resources Created

### DynamoDB Tables (NoSQL)

| Table                  | Purpose                             | GSIs                 |
| ---------------------- | ----------------------------------- | -------------------- |
| `pigbank-users`        | User profiles, credentials, avatars | EmailIndex           |
| `pigbank-cards`        | Debit/credit cards per user         | UserIndex, TypeIndex |
| `pigbank-transactions` | Financial movements history         | UserIndex, CardIndex |

---

### S3 Buckets (Storage)

| Bucket                      | Purpose                          |
| --------------------------- | -------------------------------- |
| `pigbank-user-avatars-*`    | Profile pictures (Base64 → JPEG) |
| `pigbank-reports-*`         | CSV/Excel transaction reports    |
| `pigbank-email-templates-*` | HTML templates for notifications |

---

### 📩 SQS Queues (Event-Driven)

| Queue                     | DLQ | Purpose                            |
| ------------------------- | --- | ---------------------------------- |
| `create-request-card-sqs` | ✅   | Card creation on user registration |
| `notification-email-sqs`  | ✅   | Email delivery async               |

---

## LocalStack Configuration

```hcl
provider "aws" {
  endpoints {
    dynamodb = "http://localhost:4566"
    s3       = "http://localhost:4566"
    sqs      = "http://localhost:4566"
  }

  s3_use_path_style = true
}
```

---

## Commands

```bash
# Start LocalStack
docker compose up -d

# Deploy infrastructure
terraform init
terraform apply -auto-approve

# Verify resources
terraform state list
```

---

## Outputs

```bash
terraform output
```

Muestra:

* Queue URLs
* Bucket names
* Table names

---

##  Resilience Features

* Dead Letter Queues (3 retries, 14-day retention)
* DynamoDB PAY_PER_REQUEST (auto-scaling)
* SQS Long Polling (10s wait time)

---
