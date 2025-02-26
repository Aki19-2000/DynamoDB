resource "aws_lambda_function" "lambda_function" {
  function_name    = var.function_name
  runtime         = "python3.9"
  handler         = "lambda_function.lambda_handler"
  role            = var.role_arn
  filename        = "lambda.zip"

  environment {
    variables = {
      TABLE_NAME = var.table_name
    }
  }
}
