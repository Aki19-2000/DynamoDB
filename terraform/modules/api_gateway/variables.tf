variable "read_data_lambda_arn" {
  description = "The ARN of the read_data_lambda function"
  type        = string
}

variable "insert_data_lambda_arn" {
  description = "The ARN of the insert_data_lambda function"
  type        = string
}
variable "region" {
  description = "The AWS region to deploy the resources"
  type        = string
}

