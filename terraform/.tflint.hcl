# Enable or disable specific rules for AWS Lambda
rule "aws_lambda_function_timeout" {
  enabled = true
  severity = "error"  # You can set severity to 'error', 'warning', or 'info'
}

rule "aws_lambda_function_memory_size" {
  enabled = true
  severity = "warning"
}

rule "aws_lambda_function_environment_variables" {
  enabled = true
  severity = "error"
}
