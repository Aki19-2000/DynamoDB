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
  source = "./modules/lambda"
}

module "api_gateway" {
  source = "./modules/api_gateway"
}
