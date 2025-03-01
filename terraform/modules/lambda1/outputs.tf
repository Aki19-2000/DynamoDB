output "insert_data_lambda_arn" {
  value = aws_lambda_function.insert_data_lambda.arn
}

output "read_data_lambda_arn" {
  value = aws_lambda_function.read_data_lambda.arn
}
