# tflint-ignore: terraform_unused_declarations
variable "region" {
  type    = string
  default = "us-east-1"
}

# tflint-ignore: terraform_unused_declarations
variable "account_id" {
  type        = string
  description = "AWS Account ID"
  default     = "510278866235"
}
