provider "aws" {
  region = "us-east-1"
}

module "dynamodb" {
  source     = "./modules/dynamodb"
  table_name = "serverless_workshop_intro"  # Provide the table name here
  hash_key   = "Userid"  # Provide the hash key here
}


module "iam" {
  source = "./modules/iam"
}

module "lambda" {
  source      = "./modules/lambda"
  function_name = "my_lambda_function"  # Provide the Lambda function name
  role_arn     = "arn:aws:iam::123456789012:role/my-lambda-role"  # Provide the IAM role ARN for Lambda
  table_name   = "serverless_workshop_intro"  # Provide the DynamoDB table name
}


module "api_gateway" {
  source = "./modules/api_gateway"
}
