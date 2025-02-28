terraform {
  required_version = ">= 1.0.0"
}

module "dynamodb" {
  source      = "./modules/dynamodb"
  table_name  = "serverless_workshop_intro"
  hash_key    = "Userid"
}

module "iam" {
  source      = "./modules/iam"
  table_name  = module.dynamodb.table_name
  account_id  = "510278866235"  # Replace with your actual AWS account ID
}

# First Lambda: Insert Data Lambda
module "insert_data_lambda" {
  source        = "./modules/lambda"
  function_name = "insert_data_lambda-${terraform.workspace}"
  role_arn      = module.iam.lambda_role_arn
  table_name    = module.dynamodb.table_name
}

# Second Lambda: Read Data Lambda
module "read_data_lambda" {
  source        = "./modules/lambda"
  function_name = "read_data_lambda-${terraform.workspace}"
  role_arn      = module.iam.lambda_role_arn
  table_name    = module.dynamodb.table_name
}

module "api_gateway" {
  source              = "./modules/api_gateway"
  read_data_lambda_arn = module.read_data_lambda.read_data_lambda_arn
  insert_data_lambda_arn = module.insert_data_lambda.insert_data_lambda_arn
  region              = "us-east-1"  # Pass the region
}

output "api_url" {
  value = module.api_gateway.api_url
}
