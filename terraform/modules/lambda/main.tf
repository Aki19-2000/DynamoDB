data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}"
  output_path = "${path.module}/lambda_function.zip"
}

resource "aws_lambda_function" "lambda_function" {
  function_name    = var.function_name
  runtime         = "python3.9"
  handler         = "lambda_function.lambda_handler"
  role            = var.role_arn
  filename        = data.archive_file.lambda_zip.output_path

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      TABLE_NAME = var.table_name
    }
  }
}
