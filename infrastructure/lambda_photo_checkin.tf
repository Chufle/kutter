resource "aws_lambda_function" "photo_checkin" {
  function_name = "photo_checkin"
  filename       = "build/photo_checkin.zip"
  role          = "arn:aws:iam::705920657793:role/LabRole"
  handler       = "photo_checkin.handler"
  timeout       = 300
  runtime       = "python3.9"
  source_code_hash = filebase64sha256("build/photo_checkin.zip")
}