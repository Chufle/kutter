resource "aws_iam_policy" "nfish-des-pol-lambda_s3_access" {
  name        = "nfish-des-pol-lambda_s3_access"
  description = "access to s3 for lambda"
  path        = "/"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role" "nfish-des-role-lambda_s3_access" {
  name = "nfish-des-role-lambda_s3_access"

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

resource "aws_iam_role_policy_attachment" "nfish-des-lambda_s3_access" {
  role       = aws_iam_role.nfish-des-role-lambda_s3_access.name
  for_each = toset([
  aws_iam_policy.nfish-des-pol-lambda_s3_access.arn,
  "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
  "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
  ])
  policy_arn = each.value
}

data "aws_iam_role" "nfish-des-role-lambda_s3_access" {
  name = "nfish-des-role-lambda_s3_access"
  depends_on = [
    aws_iam_role.nfish-des-role-lambda_s3_access
  ]
}
