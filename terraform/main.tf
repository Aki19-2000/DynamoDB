module "insert_data_lambda" {
  source        = "./modules/lambda"
  function_name = "insert_data_lambda"  # Unique function name for this Lambda
  role_arn      = module.iam.lambda_role_arn
  table_name    = module.dynamodb.table_name
}

module "read_data_lambda" {
  source        = "./modules/lambda"
  function_name = "read_data_lambda"  # Unique function name for this Lambda
  role_arn      = module.iam.lambda_role_arn
  table_name    = module.dynamodb.table_name
}

module "api_gateway" {
  source                 = "./modules/api_gateway"
  read_data_lambda_arn   = module.read_data_lambda.read_data_lambda_arn
  insert_data_lambda_arn = module.insert_data_lambda.insert_data_lambda_arn
  region                 = "us-east-1"  # Pass the region
}

output "api_url" {
  value = module.api_gateway.api_url
}
