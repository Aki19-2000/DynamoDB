module "dynamodb" {
  source      = "./modules/dynamodb"
  table_name  = "serverless_workshop_intro"  # Provide the table name here
  hash_key    = "Userid"                     # Provide the hash key here
}

module "iam" {
  source      = "./modules/iam"
  table_name  = module.dynamodb.table_name  # Pass the DynamoDB table name
}

# First Lambda: Insert Data Lambda
module "insert_data_lambda" {
  source        = "./modules/lambda"
  function_name = "insert_data_lambda"
  role_arn      = module.iam.lambda_role_arn
  table_name    = module.dynamodb.table_name
}

# Second Lambda: Read Data Lambda
module "read_data_lambda" {
  source        = "./modules/lambda"
  function_name = "read_data_lambda"
  role_arn      = module.iam.lambda_role_arn
  table_name    = module.dynamodb.table_name
}

module "api_gateway" {
  source              = "./modules/api_gateway"
  read_data_lambda_arn = module.read_data_lambda.lambda_function_arn  # Pass the ARN to API Gateway
  insert_data_lambda_arn = module.insert_data_lambda.lambda_function_arn  # Pass the ARN to API Gateway
}
