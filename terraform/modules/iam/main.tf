resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow"
      }
    ]
  }
  EOF
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_dynamodb_policy"
  description = "IAM policy for Lambda to access DynamoDB"
  
  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "dynamodb:PutItem",
          "dynamodb:Scan"
        ],
        "Resource": "*"
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
