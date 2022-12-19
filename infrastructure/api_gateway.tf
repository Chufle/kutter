resource "aws_api_gateway_rest_api" "kutter_API" {
  name        = "kutter-API"
  description = "for AWS Lambda trigger"
}

resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = "${aws_api_gateway_rest_api.kutter_API.id}"
  resource_id   = "${aws_api_gateway_rest_api.kutter_API.root_resource_id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_root" {
  rest_api_id = "${aws_api_gateway_rest_api.kutter_API.id}"
  resource_id = "${aws_api_gateway_method.proxy_root.resource_id}"
  http_method = "${aws_api_gateway_method.proxy_root.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.list_objects.invoke_arn}"
}

resource "aws_api_gateway_deployment" "kutter" {
  depends_on = [
    aws_api_gateway_integration.lambda_get_object,
    aws_api_gateway_integration.lambda_search_objects,
    aws_api_gateway_integration.lambda_news_crawler,
    aws_api_gateway_integration.lambda_root,
  ]

  rest_api_id = "${aws_api_gateway_rest_api.kutter_API.id}"
  stage_name  = "prod"
}

output "API_id" {
  value = aws_api_gateway_rest_api.kutter_API.id
}
