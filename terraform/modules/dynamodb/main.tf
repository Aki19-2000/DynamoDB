resource "aws_dynamodb_table" "serverless_workshop_intro" {
  name           = var.table_name  # Use the table_name variable
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = var.hash_key   # Use the hash_key variable

  # Primary key
  attribute {
    name = var.hash_key   # Use the hash_key variable for the attribute
    type = "S"
  }

  # Attribute for _id
  attribute {
    name = "_id"
    type = "S"
  }

  # Global Secondary Index (GSI) for querying _id
  global_secondary_index {
    name               = "_id-index"
    hash_key           = "_id"
    projection_type    = "ALL"
    read_capacity      = 5  # Optional, can be omitted for PAY_PER_REQUEST
    write_capacity     = 5  # Optional, can be omitted for PAY_PER_REQUEST
  }

  tags = {
    Environment = "production"
  }
}
