resource "aws_api_gateway_resource" "search_objects" {
  rest_api_id = "${aws_api_gateway_rest_api.kutter_API.id}"
  parent_id   = "${aws_api_gateway_rest_api.kutter_API.root_resource_id}"
  path_part   = "search-objects"
}

resource "aws_api_gateway_method" "search_objects" {
  rest_api_id   = "${aws_api_gateway_rest_api.kutter_API.id}"
  resource_id   = "${aws_api_gateway_resource.search_objects.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_search_objects" {
  rest_api_id = "${aws_api_gateway_rest_api.kutter_API.id}"
  resource_id = "${aws_api_gateway_method.search_objects.resource_id}"
  http_method = "${aws_api_gateway_method.search_objects.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.search_objects.invoke_arn}"
}
