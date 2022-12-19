resource "aws_lambda_permission" "apigw_put_project_object" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.put_project_object.function_name}"
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_rest_api.kutter_API.execution_arn}/*/*"
}

resource "aws_lambda_function" "put_project_object" {
  function_name = "put_project_object"
  filename      = "build/put_project_object.zip"
  role          = aws_iam_role.nfish-des-role-lambda_dynamodb.arn
  handler       = "put_project_object.handler"
  timeout       = 300
  runtime       = "python3.9"
  source_code_hash = filebase64sha256("build/put_project_object.zip")

  environment {
    variables = {
      KUTTER_TABLE_NAME = aws_dynamodb_table.dynamodb-kutter-table.name
    }
  }
}
