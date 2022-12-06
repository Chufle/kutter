resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.photo_checkin.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.nfish-des-kutter-photos.arn
}

resource "aws_lambda_function" "photo_checkin" {
  function_name = "photo_checkin"
  filename      = "build/photo_checkin.zip"
  role          = aws_iam_role.nfish-des-role-lambda_s3_dynamodb.arn
  handler       = "photo_checkin.handler"
  timeout       = 300
  runtime       = "python3.9"
  source_code_hash = filebase64sha256("build/photo_checkin.zip")

  environment {
    variables = {
      KUTTER_TABLE_NAME = aws_dynamodb_table.dynamodb-kutter-table.name
    }
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.nfish-des-kutter-photos.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.photo_checkin.arn
    events              = ["s3:ObjectCreated:*"]
  }
  
  depends_on = [aws_lambda_permission.allow_bucket]
}
