resource "aws_api_gateway_integration" "read_data_integration" {
  rest_api_id = aws_api_gateway_rest_api.serverless_api.id
  resource_id = aws_api_gateway_resource.read_data.id
  http_method = aws_api_gateway_method.get_read_data.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.read_data_lambda_arn}/invocations"
}

resource "aws_api_gateway_integration" "insert_data_integration" {
  rest_api_id = aws_api_gateway_rest_api.serverless_api.id
  resource_id = aws_api_gateway_resource.read_data.id
  http_method = aws_api_gateway_method.get_read_data.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.insert_data_lambda_arn}/invocations"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.read_data_integration,
    aws_api_gateway_integration.insert_data_integration
  ]
  rest_api_id = aws_api_gateway_rest_api.serverless_api.id
  stage_name  = "prod"
}
