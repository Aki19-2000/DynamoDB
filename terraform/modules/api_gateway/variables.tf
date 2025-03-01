variable "region" {
  description = "The AWS region where resources are deployed"
  type        = string
}

variable "read_data_lambda_arn" {
  description = "The ARN of the read data lambda function"
  type        = string
}

variable "insert_data_lambda_arn" {
  description = "The ARN of the insert data lambda function"
  type        = string
}
variable "api_stage" {
  description = "The stage name for the API Gateway"
  type        = string
}

