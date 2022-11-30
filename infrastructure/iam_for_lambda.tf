resource "aws_iam_policy" "nfish-des-pol-lambda_s3_dynamodb" {
  name        = "nfish-des-pol-lambda_s3_dynamodb"
  description = "access to s3 and dynamodb for lambda"
  path        = "/"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3-object-lambda:Get*",
                "s3-object-lambda:PutObject",
                "s3-object-lambda:DeleteObject"
            ],
            "Resource": "arn:aws:s3:::nfish-des-kutter-photos"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:DescribeStream",
                "dynamodb:DescribeTable",
                "dynamodb:Get*",
                "dynamodb:Query",
                "dynamodb:Scan",
                "dynamodb:DeleteItem",
                "dynamodb:UpdateItem",
                "dynamodb:PutItem"
            ],
            "Resource": "arn:aws:dynamodb:us-west-2:${data.aws_caller_identity.current.account_id}:table/kutter-table"
        }
    ]
}
EOF
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
