# Define the API Gateway REST API
resource "aws_api_gateway_rest_api" "this" {
  name        = "${var.read_data_lambda_arn}-api"
  description = "API Gateway to trigger ${var.read_data_lambda_arn}"
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
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.read_data_lambda_arn}/invocations"
}

# Lambda permissions for API Gateway to invoke the Lambda function
resource "aws_lambda_permission" "read_data_permission" {
  action        = "lambda:InvokeFunction"
  function_name = var.read_data_lambda_arn
  principal     = "apigateway.amazonaws.com"
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  depends_on = [
    aws_api_gateway_integration.get_integration,
    aws_api_gateway_method.get_method
  ]
}

# Create API Gateway Stage explicitly (replacing the deprecated stage_name attribute)
resource "aws_api_gateway_stage" "prod_stage" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.this.id
  deployment_id = aws_api_gateway_deployment.this.id

  lifecycle {
    ignore_changes = [deployment_id]  # Ignore changes to deployment_id (if stage already exists)
  }
}

# Output the API Gateway URL (optional)
output "api_url" {
  value = "https://${aws_api_gateway_rest_api.this.id}.execute-api.${var.region}.amazonaws.com/${var.api_stage}/"
}
