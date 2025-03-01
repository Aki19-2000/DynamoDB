variable "read_data_lambda_arn" {
  description = "ARN for the Read Data Lambda function"
  type        = string
}

variable "insert_data_lambda_arn" {
  description = "ARN for the Insert Data Lambda function"
  type        = string
}

variable "api_stage" {
  description = "The stage name for the API Gateway"
  type        = string
}

variable "region" {
  description = "The AWS region"
  type        = string
}
