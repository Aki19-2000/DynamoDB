resource "aws_dynamodb_table" "serverless_workshop_intro" {
  name           = var.table_name  # Use the table_name variable
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = var.hash_key   # Use the hash_key variable

  attribute {
    name = var.hash_key   # Use the hash_key variable for the attribute
    type = "S"
  }

  attribute {
    name = "_id"
    type = "S"
  }

  tags = {
    Environment = "production"
  }
}
