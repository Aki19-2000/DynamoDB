resource "aws_api_gateway_rest_api" "this" {
  name        = "${var.read_data_lambda_arn}-api"
  description = "API Gateway to trigger ${var.read_data_lambda_arn}"
}

resource "aws_api_gateway_resource" "read_data" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "read_data"
}

resource "aws_api_gateway_method" "get_method" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.read_data.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.read_data.id
  http_method             = aws_api_gateway_method.get_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.read_data_lambda_arn}/invocations"
}

resource "aws_api_gateway_resource" "insert_data" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "insert_data"
}

resource "aws_api_gateway_method" "post_method" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.insert_data.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.insert_data.id
  http_method             = aws_api_gateway_method.post_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.insert_data_lambda_arn}/invocations"
}

resource "aws_lambda_permission" "read_data_permission" {
  action        = "lambda:InvokeFunction"
  function_name = var.read_data_lambda_arn
  principal     = "apigateway.amazonaws.com"
}

resource "aws_lambda_permission" "insert_data_permission" {
  action        = "lambda:InvokeFunction"
  function_name = var.insert_data_lambda_arn
  principal     = "apigateway.amazonaws.com"
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = "prod"

  depends_on = [
    aws_api_gateway_integration.get_integration,
    aws_api_gateway_method.get_method,
    aws_api_gateway_integration.post_integration,
    aws_api_gateway_method.post_method
  ]
}

resource "aws_api_gateway_stage" "prod_stage" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.this.id
  deployment_id = aws_api_gateway_deployment.this.id
}

output "api_url" {
  value = "https://${aws_api_gateway_rest_api.this.id}.execute-api.${var.region}.amazonaws.com/${var.api_stage}/"
}
