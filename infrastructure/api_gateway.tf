resource "aws_api_gateway_rest_api" "kutter-API" {
  name        = "kutter-API"
  description = "for AWS Lambda trigger"
}

resource "aws_api_gateway_resource" "list-objects" {
  rest_api_id = "${aws_api_gateway_rest_api.kutter-API.id}"
  parent_id   = "${aws_api_gateway_rest_api.kutter-API.root_resource_id}"
  path_part   = "list-objects"
}

resource "aws_api_gateway_method" "list-objects" {
  rest_api_id   = "${aws_api_gateway_rest_api.kutter-API.id}"
  resource_id   = "${aws_api_gateway_resource.list-objects.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = "${aws_api_gateway_rest_api.kutter-API.id}"
  resource_id = "${aws_api_gateway_method.list-objects.resource_id}"
  http_method = "${aws_api_gateway_method.list-objects.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.list_objects.invoke_arn}"
}

resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = "${aws_api_gateway_rest_api.kutter-API.id}"
  resource_id   = "${aws_api_gateway_rest_api.kutter-API.root_resource_id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_root" {
  rest_api_id = "${aws_api_gateway_rest_api.kutter-API.id}"
  resource_id = "${aws_api_gateway_method.proxy_root.resource_id}"
  http_method = "${aws_api_gateway_method.proxy_root.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.list_objects.invoke_arn}"
}

resource "aws_api_gateway_deployment" "list-objects" {
  depends_on = [
    aws_api_gateway_integration.lambda,
    aws_api_gateway_integration.lambda_root,
  ]

  rest_api_id = "${aws_api_gateway_rest_api.kutter-API.id}"
  stage_name  = "prod"
}

output "API-id" {
  value = aws_api_gateway_rest_api.kutter-API.id
}
