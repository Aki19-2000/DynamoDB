resource "aws_api_gateway_rest_api" "api" {
  name        = var.api_name
  description = "API Gateway for Lambda functions"
}

resource "aws_api_gateway_resource" "insert_resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "insert"
}

resource "aws_api_gateway_resource" "read_resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "read"
}

resource "aws_api_gateway_method" "insert_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.insert_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "read_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.read_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "insert_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.insert_resource.id
  http_method = aws_api_gateway_method.insert_method.http_method
  type        = "AWS_PROXY"
  integration_http_method = "POST"
  uri         = var.insert_data_lambda_arn
}

resource "aws_api_gateway_integration" "read_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.read_resource.id
  http_method = aws_api_gateway_method.read_method.http_method
  type        = "AWS_PROXY"
  integration_http_method = "POST"
  uri         = var.read_data_lambda_arn
}

resource "aws_lambda_permission" "api_gateway_insert" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.insert_data_lambda_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

resource "aws_lambda_permission" "api_gateway_read" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.read_data_lambda_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.insert_integration,
    aws_api_gateway_integration.read_integration
  ]
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = var.api_stage
}

output "api_url" {
  value = "${aws_api_gateway_deployment.api_deployment.invoke_url}/${var.api_stage}"
}
