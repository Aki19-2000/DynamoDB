provider "aws" {
  region = "us-east-1"
}

module "dynamodb" {
  source      = "./modules/dynamodb"
  table_name  = "MyDynamoDBTable"
  hash_key    = "_id"
}

module "iam" {
  source      = "./modules/iam"
  lambda_name = "bulk_insert_lambda"
}

module "lambda" {
  source        = "./modules/lambda"
  function_name = "bulk_insert_lambda"
  role_arn      = module.iam.lambda_role_arn
  table_name    = module.dynamodb.table_name
}

module "api_gateway" {
  source        = "./modules/api_gateway"
  function_name = module.lambda.function_name
}
