# Following policies for s3, dynamodb and logs access:

resource "aws_iam_policy" "nfish-des-pol-lambda_s3_dynamodb" {
  name        = "nfish-des-pol-lambda_s3_dynamodb"
  description = "access to s3 and dynamodb for lambda"
  path        = "/"

  policy = data.aws_iam_policy_document.kutter_lambda_s3_logs_db.json
}

resource "aws_iam_role" "nfish-des-role-lambda_s3_dynamodb" {
  name = "nfish-des-role-lambda_s3_dynamodb"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "nfish-des-lambda_s3_dynamodb" {
  role       = aws_iam_role.nfish-des-role-lambda_s3_dynamodb.name
  policy_arn = aws_iam_policy.nfish-des-pol-lambda_s3_dynamodb.arn
}

data "aws_iam_role" "nfish-des-role-lambda_s3_dynamodb" {
  name = "nfish-des-role-lambda_s3_dynamodb"
  depends_on = [
    aws_iam_role.nfish-des-role-lambda_s3_dynamodb
  ]
}

# Following policies for dynamodb and logs access:

resource "aws_iam_policy" "nfish-des-pol-lambda_dynamodb" {
  name        = "nfish-des-pol-lambda_dynamodb"
  description = "access to dynamodb for lambda"
  path        = "/"

  policy = data.aws_iam_policy_document.kutter_lambda_logs_db.json
}

resource "aws_iam_role" "nfish-des-role-lambda_dynamodb" {
  name = "nfish-des-role-lambda_dynamodb"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "nfish-des-lambda_dynamodb" {
  role       = aws_iam_role.nfish-des-role-lambda_dynamodb.name
  policy_arn = aws_iam_policy.nfish-des-pol-lambda_dynamodb.arn
}

data "aws_iam_role" "nfish-des-role-lambda_dynamodb" {
  name = "nfish-des-role-lambda_dynamodb"
  depends_on = [
    aws_iam_role.nfish-des-role-lambda_dynamodb
  ]
}
