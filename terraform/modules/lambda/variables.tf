variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role to be assumed by Lambda"
  type        = string
}

variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}
