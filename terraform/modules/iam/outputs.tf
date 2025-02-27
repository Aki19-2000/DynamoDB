output "lambda_role_arn" {
  value = aws_iam_role.lambda_dynamodb_role.arn  # Ensure the correct role ARN is output
}
