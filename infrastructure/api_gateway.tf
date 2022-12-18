resource "aws_api_gateway_rest_api" "kutter_API" {
  name        = "kutter-API"
  description = "for AWS Lambda trigger"
}

# get-object endpoint:

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

# search-objects endpoint:

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

# news-crawler endpoint:

resource "aws_api_gateway_resource" "news_crawler" {
  rest_api_id = "${aws_api_gateway_rest_api.kutter_API.id}"
  parent_id   = "${aws_api_gateway_rest_api.kutter_API.root_resource_id}"
  path_part   = "news-crawler"
}

resource "aws_api_gateway_method" "news_crawler" {
  rest_api_id   = "${aws_api_gateway_rest_api.kutter_API.id}"
  resource_id   = "${aws_api_gateway_resource.news_crawler.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_news_crawler" {
  rest_api_id = "${aws_api_gateway_rest_api.kutter_API.id}"
  resource_id = "${aws_api_gateway_method.news_crawler.resource_id}"
  http_method = "${aws_api_gateway_method.news_crawler.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.news_crawler.invoke_arn}"
}

# put-project-object endpoint:
resource "aws_api_gateway_resource" "put_project_object" {
  rest_api_id = "${aws_api_gateway_rest_api.kutter_API.id}"
  parent_id   = "${aws_api_gateway_rest_api.kutter_API.root_resource_id}"
  path_part   = "put-project-object"
}

resource "aws_api_gateway_method" "put_project_object" {
  rest_api_id   = "${aws_api_gateway_rest_api.kutter_API.id}"
  resource_id   = "${aws_api_gateway_resource.put_project_object.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_put_project_object" {
  rest_api_id = "${aws_api_gateway_rest_api.kutter_API.id}"
  resource_id = "${aws_api_gateway_method.put_project_object.resource_id}"
  http_method = "${aws_api_gateway_method.put_project_object.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.put_project_object.invoke_arn}"
}

# list-objects endpoint (root):

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
    aws_api_gateway_integration.lambda_put_project_object,
    aws_api_gateway_integration.lambda_root,
  ]

  rest_api_id = "${aws_api_gateway_rest_api.kutter_API.id}"
  stage_name  = "prod"
}

output "API_id" {
  value = aws_api_gateway_rest_api.kutter_API.id
}
