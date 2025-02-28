# Enable AWS plugin for TFLint
plugin "aws" {
  enabled = true
  version = "v0.25.0"  # Optional: specify the plugin version if necessary
}

# Rules for AWS Lambda
rule "aws_lambda_function_runtime" {
  enabled = true
  severity = "error"  # Ensure that Lambda functions use a supported runtime (e.g., Python 3.x)
  # Check if the runtime is Python 3.x
  parameters = {
    allowed_runtimes = ["python3.8", "python3.9"]  # Example of allowed Python versions
  }
}

# Example of other Lambda rules
rule "aws_lambda_function_memory_size" {
  enabled = true
  severity = "warning"  # Ensure the memory size is set (avoid default size)
}

rule "aws_lambda_function_timeout" {
  enabled = true
  severity = "error"  # Ensure that a timeout is set for Lambda functions
}

# Rules for API Gateway (if relevant)
rule "aws_api_gateway_method" {
  enabled = true
  severity = "warning"  # Ensure API Gateway methods are properly defined
}

# Optionally, add other security rules or best practices as needed
rule "aws_security_group_rule_missing_type" {
  enabled = true
  severity = "error"  # Check that all security group rules have a specified type
}
