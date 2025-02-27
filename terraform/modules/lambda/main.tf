resource "aws_lambda_function" "insert_data_lambda" {
  function_name = var.function_name  # Use the function name variable
  role          = var.role_arn       # Use the role ARN variable
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  filename      = "lambda_functions/insert_data.zip"  # Your zipped lambda file

  environment {
    variables = {
      TABLE_NAME = var.table_name  # Use the table name variable
    }
  }
}

resource "aws_lambda_function" "read_data_lambda" {
  function_name = var.function_name  # Use the function name variable
  role          = var.role_arn       # Use the role ARN variable
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  filename      = "lambda_functions/read_data.zip"  # Your zipped lambda file

  environment {
    variables = {
      TABLE_NAME = var.table_name  # Use the table name variable
    }
  }
}
