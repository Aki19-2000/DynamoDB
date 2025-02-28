resource "null_resource" "zip_insert_data_lambda" {
  provisioner "local-exec" {
    command = "zip terraform/modules/lambda/lambda_functions/insert_data.zip terraform/modules/lambda/insert_data.py"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

resource "null_resource" "zip_read_data_lambda" {
  provisioner "local-exec" {
    command = "zip terraform/modules/lambda/lambda_functions/read_data_lambda.zip terraform/modules/lambda/read_data_lambda.py"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

resource "aws_lambda_function" "insert_data_lambda" {
  function_name = var.function_name
  role          = var.role_arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  filename      = "terraform/modules/lambda/lambda_functions/insert_data.zip"  # Path to the zip file

  environment {
    variables = {
      TABLE_NAME = var.table_name
    }
  }

  depends_on = [
    null_resource.zip_insert_data_lambda
  ]
}

resource "aws_lambda_function" "read_data_lambda" {
  function_name = var.function_name
  role          = var.role_arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  filename      = "terraform/modules/lambda/lambda_functions/read_data_lambda.zip"  # Path to the zip file

  environment {
    variables = {
      TABLE_NAME = var.table_name
    }
  }

  depends_on = [
    null_resource.zip_read_data_lambda
  ]
}
