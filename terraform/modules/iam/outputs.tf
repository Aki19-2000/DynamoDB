output "lambda_role_arn" {
  value = aws_iam_role.lambda_dynamodb_role.arn  # Corrected the reference to the actual role
}
