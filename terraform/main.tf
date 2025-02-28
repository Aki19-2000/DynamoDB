module "dynamodb" {
  source      = "./modules/dynamodb"  # This line ensures the dynamodb module is correctly referenced
  table_name  = "serverless_workshop_intro"
  hash_key    = "Userid"
}

module "iam" {
  source      = "./modules/iam"
  table_name  = module.dynamodb.table_name  # Reference to the dynamodb module's output
  account_id  = "510278866235"  # Replace with your actual AWS account ID
}

module "insert_data_lambda" {
  source        = "./modules/lambda"
  function_name = "insert_data_lambda"
  role_arn      = module.iam.lambda_role_arn
  table_name    = module.dynamodb.table_name  # Reference to the dynamodb module's output
}

module "read_data_lambda" {
  source        = "./modules/lambda"
  function_name = "read_data_lambda"
  role_arn      = module.iam.lambda_role_arn
  table_name    = module.dynamodb.table_name  # Reference to the dynamodb module's output
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
