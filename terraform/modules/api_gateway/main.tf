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
  rest_api_id   = aws_api_gateway_rest_api.serverless_api.id
  resource_id   = aws_api_gateway_resource.read_data.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "read_data_integration" {
  rest_api_id = aws_api_gateway_rest_api.serverless_api.id
  resource_id = aws_api_gateway_resource.read_data.id
  http_method = aws_api_gateway_method.get_read_data.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${aws_lambda_function.read_data_lambda.arn}/invocations"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.read_data_integration
  ]
  rest_api_id = aws_api_gateway_rest_api.serverless_api.id
  stage_name  = "prod"
}

resource "aws_lambda_permission" "allow_api_gateway" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.read_data_lambda.function_name
  principal     = "apigateway.amazonaws.com"
}
