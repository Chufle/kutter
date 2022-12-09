resource "aws_api_gateway_rest_api" "kutter-API" {
  name        = "kutter-API"
  description = "for AWS Lambda trigger"
}

# get-object endpoint:

resource "aws_api_gateway_resource" "get-object" {
  rest_api_id = "${aws_api_gateway_rest_api.kutter-API.id}"
  parent_id   = "${aws_api_gateway_rest_api.kutter-API.root_resource_id}"
  path_part   = "get-object"
}

resource "aws_api_gateway_method" "get-object" {
  rest_api_id   = "${aws_api_gateway_rest_api.kutter-API.id}"
  resource_id   = "${aws_api_gateway_resource.get-object.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = "${aws_api_gateway_rest_api.kutter-API.id}"
  resource_id = "${aws_api_gateway_method.get-object.resource_id}"
  http_method = "${aws_api_gateway_method.get-object.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.get_object.invoke_arn}"
}

# search-objects endpoint:

resource "aws_api_gateway_resource" "search-objects" {
  rest_api_id = "${aws_api_gateway_rest_api.kutter-API.id}"
  parent_id   = "${aws_api_gateway_rest_api.kutter-API.root_resource_id}"
  path_part   = "search-objects"
}

resource "aws_api_gateway_method" "search-objects" {
  rest_api_id   = "${aws_api_gateway_rest_api.kutter-API.id}"
  resource_id   = "${aws_api_gateway_resource.search-objects.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = "${aws_api_gateway_rest_api.kutter-API.id}"
  resource_id = "${aws_api_gateway_method.search-objects.resource_id}"
  http_method = "${aws_api_gateway_method.search-objects.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.search_objects.invoke_arn}"
}

# list-objects endpoint (root):

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

resource "aws_api_gateway_deployment" "kutter" {
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
