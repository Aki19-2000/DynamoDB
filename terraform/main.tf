module "dynamodb" {
  source      = "./modules/dynamodb"
  table_name  = "serverless_workshop_intro"  # Provide the table name here
  hash_key    = "Userid"                     # Provide the hash key here
}

module "iam" {
  source = "./modules/iam"
}

# First Lambda: Insert Data Lambda
module "insert_data_lambda" {
  source        = "./modules/lambda"
  function_name = "insert_data_lambda"  # Provide the function name for the insert data Lambda
  role_arn      = module.iam.lambda_role_arn  # Reference the IAM role ARN output
  table_name    = module.dynamodb.table_name  # Reference the DynamoDB table name
}

# Second Lambda: Read Data Lambda
module "read_data_lambda" {
  source        = "./modules/lambda"
  function_name = "read_data_lambda"  # Provide the function name for the read data Lambda
  role_arn      = module.iam.lambda_role_arn  # Reference the IAM role ARN output
  table_name    = module.dynamodb.table_name  # Reference the DynamoDB table name
}

module "api_gateway" {
  source = "./modules/api_gateway"
}
