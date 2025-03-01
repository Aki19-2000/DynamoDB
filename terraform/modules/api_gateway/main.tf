resource "aws_api_gateway_rest_api" "serverless_api" {
  name        = "ServerlessAPI"
  description = "API for interacting with DynamoDB"
}

resource "aws_api_gateway_resource" "read_data" {
  rest_api_id = aws_api_gateway_rest_api.serverless_api.id
  parent_id   = aws_api_gateway_rest_api.serverless_api.root_resource_id
  path_part   = "read_data"
}

resource "aws_api_gateway_method" "get_read_data" {
  rest_api_id = aws_api_gateway_rest_api.serverless_api.id
  resource_id = aws_api_gateway_resource.read_data.id
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "read_data_integration" {
  rest_api_id             = aws_api_gateway_rest_api.serverless_api.id
  resource_id            = aws_api_gateway_resource.read_data.id
  http_method            = aws_api_gateway_method.get_read_data.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.read_data_lambda_arn}/invocations"
}

resource "aws_api_gateway_resource" "insert_data" {
  rest_api_id = aws_api_gateway_rest_api.serverless_api.id
  parent_id   = aws_api_gateway_rest_api.serverless_api.root_resource_id
  path_part   = "insert_data"
}

resource "aws_api_gateway_method" "post_insert_data" {
  rest_api_id = aws_api_gateway_rest_api.serverless_api.id
  resource_id = aws_api_gateway_resource.insert_data.id
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "insert_data_integration" {
  rest_api_id             = aws_api_gateway_rest_api.serverless_api.id
  resource_id            = aws_api_gateway_resource.insert_data.id
  http_method            = aws_api_gateway_method.post_insert_data.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.insert_data_lambda_arn}/invocations"
}

# API Gateway Deployment
resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.read_data_integration,
    aws_api_gateway_integration.insert_data_integration
  ]
  rest_api_id = aws_api_gateway_rest_api.serverless_api.id
}

# API Gateway Stage - Create the stage after deployment
resource "aws_api_gateway_stage" "prod_stage" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.serverless_api.id
  deployment_id = aws_api_gateway_deployment.api_deployment.id
}
