# Enable the AWS plugin (it will be automatically enabled by default)
plugin "aws" {
  enabled = true
}

# Rule for checking Lambda function timeout
rule "aws_lambda_function_timeout" {
  enabled = true
  severity = "error"  # Ensure that a timeout is set for Lambda functions
}

# Rule for checking Lambda function memory size
rule "aws_lambda_function_memory_size" {
  enabled = true
  severity = "warning"  # Ensure the memory size is set (avoid default size)
}
