terraform {
  required_version = ">= 1.0.0"  # Define the required Terraform version
}

module "dynamodb" {
  source      = "./modules/dynamodb"  # This line ensures the dynamodb module is correctly referenced
  table_name  = "serverless_workshop_intro"
  hash_key    = "Userid"
}

module "iam" {
  source = "./modules/iam"
  table_name  = module.dynamodb.table_name
  account_id  = "510278866235"
  lambda_function_name = "insert_data_lambda"
}

module "iam1" {
  source = "./modules/iam1"
  lambda_function_name = "read_data"
  table_name  = module.dynamodb.table_name
  account_id  = "510278866235"
}

module "insert_data_lambda" {
  source        = "./modules/lambda"
  function_name = "insert_data_lambda"
  workspace     = terraform.workspace  # Pass the current workspace
  role_arn      = module.iam.lambda_role_arn
  table_name    = module.dynamodb.table_name
}

module "read_data_lambda" {
  source        = "./modules/lambda1"
  function_name = "read_data"
  workspace     = terraform.workspace  # Pass the current workspace
  role_arn      = module.iam.lambda_role_arn
  table_name    = module.dynamodb.table_name
}
module "api_gateway" {
  source                 = "./modules/api_gateway"
  api_stage             = "prod"
  read_data_lambda_arn   = module.read_data_lambda.read_data_lambda_arn
  insert_data_lambda_arn = module.insert_data_lambda.insert_data_lambda_arn
  region                 = "us-east-1"  # Pass the region
}

output "api_url" {
  value = module.api_gateway.api_url
}
