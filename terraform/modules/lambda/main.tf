resource "aws_lambda_function" "insert_data_lambda" {
  function_name = var.function_name
  role          = var.role_arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  filename      = "terraform/modules/lambda/lambda_functions/insert_data.zip"  # Correct path to the zip file

  environment {
    variables = {
      TABLE_NAME = var.table_name
    }
  }
}

resource "aws_lambda_function" "read_data_lambda" {
  function_name = var.function_name
  role          = var.role_arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  filename      = "terraform/modules/lambda/lambda_functions/read_data_lambda.zip"  # Correct path to the zip file

  environment {
    variables = {
      TABLE_NAME = var.table_name
    }
  }
}
