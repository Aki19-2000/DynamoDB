# Enable AWS plugin for TFLint
plugin "aws" {
  enabled = true
  version = "v0.25.0"  # Optional: specify version
}

# Rules for AWS Lambda
rule "aws_lambda_function_timeout" {
  enabled = true
  severity = "error"  # Enforce setting a timeout for Lambda functions
}

rule "aws_lambda_function_memory_size" {
  enabled = true
  severity = "warning"  # Ensure proper memory size for Lambda functions
}

rule "aws_lambda_function_environment_variables" {
  enabled = true
  severity = "error"  # Ensure Lambda functions use environment variables correctly
}

# Rules for AWS API Gateway
rule "aws_api_gateway_stage_deployment" {
  enabled = true
  severity = "warning"  # Ensure API Gateway stages are deployed
}

rule "aws_api_gateway_method" {
  enabled = true
  severity = "warning"  # Ensure API Gateway methods are correctly defined
}

# Exclude certain directories or resources from linting
files = [
  "!modules/lambda/*",  # Exclude Lambda-related resources
  "!modules/api_gateway/*"  # Exclude API Gateway-related resources
]

# Optionally, specify the severity levels for other rules
rule "aws_security_group_rule_missing_type" {
  severity = "error"
}

# Optionally, you can also enable or configure other AWS rules that apply to your setup
