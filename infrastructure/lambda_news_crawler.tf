resource "aws_lambda_function" "news_crawler" {
  function_name = "news_crawler"
  filename      = "build/news_crawler.zip"
  role          = aws_iam_role.nfish-des-role-lambda_dynamodb.arn
  handler       = "news_crawler.handler"
  timeout       = 300
  runtime       = "python3.9"
  layers        = [aws_lambda_layer_version.requests_layer.arn]
  source_code_hash = filebase64sha256("build/news_crawler.zip")

  environment {
    variables = {
      KUTTER_TABLE_NAME = aws_dynamodb_table.dynamodb-kutter-table.name
      STORE_BUCKET_NAME = aws_s3_bucket.nfish-des-kutter-store.bucket
      NEWS_API_KEY = var.NEWS_API_KEY
    }
  }
}

resource "aws_lambda_layer_version" "requests_layer" {
  filename      = "build/requests_layer.zip"
  layer_name    = "requests_layer"

  compatible_runtimes = ["python3.9"]
}
