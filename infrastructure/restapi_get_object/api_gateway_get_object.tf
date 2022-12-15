resource "aws_api_gateway_resource" "get_object" {
  rest_api_id = "${aws_api_gateway_rest_api.kutter_API.id}"
  parent_id   = "${aws_api_gateway_rest_api.kutter_API.root_resource_id}"
  path_part   = "get-object"
}

resource "aws_api_gateway_method" "get_object" {
  rest_api_id   = "${aws_api_gateway_rest_api.kutter_API.id}"
  resource_id   = "${aws_api_gateway_resource.get_object.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_get_object" {
  rest_api_id = "${aws_api_gateway_rest_api.kutter_API.id}"
  resource_id = "${aws_api_gateway_method.get_object.resource_id}"
  http_method = "${aws_api_gateway_method.get_object.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.get_object.invoke_arn}"
}
