output "api_url" {
  value = "${aws_api_gateway_deployment.api_deployment.invoke_url}/prod"
}
