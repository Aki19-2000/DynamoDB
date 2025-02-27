resource "aws_lambda_function" "insert_data_lambda" {
  function_name = "insert_data_lambda"
  role          = aws_iam_role.lambda_dynamodb_role.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  filename      = "lambda_functions/insert_data.zip"  # Your zipped lambda file

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.serverless_workshop_intro.name
    }
  }
}

resource "aws_lambda_function" "read_data_lambda" {
  function_name = "read_data_lambda"
  role          = aws_iam_role.lambda_dynamodb_role.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  filename      = "lambda_functions/read_data.zip"  # Your zipped lambda file

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.serverless_workshop_intro.name
    }
  }
}

