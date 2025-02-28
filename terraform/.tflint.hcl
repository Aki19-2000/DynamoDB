# Enable AWS plugin for TFLint
plugin "aws" {
  enabled = true  # This argument is required
  source  = "terraform-linters/tflint-ruleset-aws"  # Specify the source for the AWS plugin
  version = "v0.25.0"  # Specify the plugin version
}

# Simple rule: Ensure AWS Lambda uses a supported runtime (Python 3.x in this case)
rule "aws_lambda_function_runtime" {
  enabled = true  # Enable this rule
  severity = "error"  # Set severity level to error
  parameters = {
    allowed_runtimes = ["python3.8", "python3.9"]  # Example: Only allow Python 3.8 or 3.9 for Lambda functions
  }
}
