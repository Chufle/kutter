resource "aws_lambda_function" "news_crawler" {
  function_name = "news_crawler"
  filename      = "build/news_crawler.zip"
  role          = aws_iam_role.nfish-des-role-lambda_dynamodb.arn
  handler       = "news_crawler.handler"
  timeout       = 300
  runtime       = "python3.9"
  source_code_hash = filebase64sha256("build/news_crawler.zip")

  environment {
    variables = {
      KUTTER_TABLE_NAME = aws_dynamodb_table.dynamodb-kutter-table.name
      STORE_BUCKET_NAME = aws_s3_bucket.nfish-des-kutter-store.bucket
    }
  }
}
