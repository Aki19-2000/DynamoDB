# Simple rule: Ensure AWS Lambda uses a supported runtime (Python 3.x in this case)
rule "aws_lambda_function_runtime" {
  enabled = true  # Enable this rule
  severity = "error"  # Set severity level to error
  parameters = {
    allowed_runtimes = ["python3.8", "python3.9"]  # Example: Only allow Python 3.8 or 3.9 for Lambda functions
  }
}
