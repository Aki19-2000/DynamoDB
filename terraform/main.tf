module "dynamodb" {
  source      = "./modules/dynamodb"
  table_name  = "serverless_workshop_intro"  # Provide the table name here
  hash_key    = "Userid"                     # Provide the hash key here
}

module "iam" {
  source = "./modules/iam"
}

module "lambda" {
  source        = "./modules/lambda"
  function_name = "my_lambda_function"  # Provide the Lambda function name
  role_arn      = module.iam.lambda_role_arn  # Reference the IAM role ARN output
  table_name    = module.dynamodb.table_name  # Reference the DynamoDB table name
}

module "api_gateway" {
  source = "./modules/api_gateway"
}
