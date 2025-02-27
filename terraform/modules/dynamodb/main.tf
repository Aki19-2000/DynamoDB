resource "aws_dynamodb_table" "serverless_workshop_intro" {
  name           = "serverless_workshop_intro"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "Userid"
  attribute {
    name = "Userid"
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
