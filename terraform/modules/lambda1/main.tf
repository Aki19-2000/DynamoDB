data "archive_file" "insert_data_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_functions/insert_data"
  output_path = "${path.module}/lambda_functions/insert_data.zip"
}

data "archive_file" "read_data_lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_functions1/read_data"
  output_path = "${path.module}/lambda_functions1/read_data.zip"
}

resource "aws_lambda_function" "insert_data_lambda" {
  function_name = var.function_name
  role          = var.role_arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  filename      = data.archive_file.insert_data_zip.output_path

  environment {
    variables = {
      TABLE_NAME = var.table_name
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      function_name,
      role,
      handler,
      runtime,
      filename,
    ]
  }
}

resource "aws_lambda_function" "read_data_lambda" {
  function_name = var.function_name
  role          = var.role_arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  filename      = data.archive_file.read_data_lambda_zip.output_path

  environment {
    variables = {
      TABLE_NAME = var.table_name
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      function_name,
      role,
      handler,
      runtime,
      filename,
    ]
  }
}
