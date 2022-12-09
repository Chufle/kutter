resource "aws_lambda_permission" "apigw_search_objects" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.search_objects.function_name}"
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_rest_api.kutter-API.execution_arn}/*/*"
}

resource "aws_lambda_function" "search_objects" {
  function_name = "search_objects"
  filename      = "build/search_objects.zip"
  role          = aws_iam_role.nfish-des-role-lambda_dynamodb.arn
  handler       = "search_objects.handler"
  timeout       = 300
  runtime       = "python3.9"
  source_code_hash = filebase64sha256("build/search_objects.zip")
}
