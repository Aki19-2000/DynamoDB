# Define the API Gateway REST API
resource "aws_api_gateway_rest_api" "this" {
  name        = "${var.lambda_function_name}-api"
  description = "API Gateway to trigger ${var.lambda_function_name}"
}

# Create a resource path for '/read_data'
resource "aws_api_gateway_resource" "read_data" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "read_data"
}

# GET Method - Allow GET requests on /read_data
resource "aws_api_gateway_method" "get_method" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.read_data.id
  http_method   = "GET"
  authorization = "NONE"
}

# Integration for GET method with Lambda (read data)
resource "aws_api_gateway_integration" "get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.read_data.id
  http_method             = aws_api_gateway_method.get_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${aws_lambda_function.read_data.arn}/invocations"
}

# Create a resource path for '/insert_data'
resource "aws_api_gateway_resource" "insert_data" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "insert_data"
}

# POST Method - Allow POST requests on /insert_data
resource "aws_api_gateway_method" "post_method" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.insert_data.id
  http_method   = "POST"
  authorization = "NONE"
}

# Integration for POST method with Lambda (insert data)
resource "aws_api_gateway_integration" "post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.insert_data.id
  http_method             = aws_api_gateway_method.post_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${aws_lambda_function.insert_data.arn}/invocations"
}

# Lambda permissions for API Gateway to invoke the Lambda function
resource "aws_lambda_permission" "read_data_permission" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.read_data.function_name
  principal     = "apigateway.amazonaws.com"
}

resource "aws_lambda_permission" "insert_data_permission" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.insert_data.function_name
  principal     = "apigateway.amazonaws.com"
}

# Deploy API Gateway to a stage
resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = var.api_stage  # Use the 'api_stage' variable for the stage name

  depends_on = [
    aws_api_gateway_integration.get_integration,
    aws_api_gateway_method.get_method,
    aws_api_gateway_integration.post_integration,
    aws_api_gateway_method.post_method
  ]
}


