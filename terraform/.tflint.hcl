plugin "aws" {
  enabled = true
  version = "0.37.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

rule "aws_lambda_function_deprecated_runtime" {
  enabled = true
}
