variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}
