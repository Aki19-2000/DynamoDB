plugin "aws" {
  enabled = true
}

rule "aws_lambda_function_runtime" {
  enabled = true
  runtime = "python3.8"
}
