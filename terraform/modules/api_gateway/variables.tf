variable "api_name" {
  description = "The name of the API Gateway"
  type        = string
  default     = "MyAPIGateway"
}

variable "api_stage" {
  description = "The stage name for the API Gateway"
  type        = string
  default     = "prod"
}

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

variable "read_data_lambda_arn" {
  description = "ARN of the read data Lambda function"
  type        = string
}

variable "insert_data_lambda_arn" {
  description = "ARN of the insert data Lambda function"
  type        = string
}

variable "read_data_lambda_name" {
  description = "Name of the read data Lambda function"
  type        = string
}

variable "insert_data_lambda_name" {
  description = "Name of the insert data Lambda function"
  type        = string
}
