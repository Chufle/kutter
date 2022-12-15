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
