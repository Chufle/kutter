data "aws_iam_policy_document" "iam_pol_doc_for_lambda" {
  statement {
    actions = [
      "s3:Get*",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      aws_s3_bucket.nfish-des-kutter-upload.arn,
      "${aws_s3_bucket.nfish-des-kutter-upload.arn}/*",
      aws_s3_bucket.nfish-des-kutter-store.arn,
      "${aws_s3_bucket.nfish-des-kutter-store.arn}/*"
    ]
  }
  statement {
    actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
    ]
    resources = [
        "*"
    ]
  }
  statement {
    actions = [
        "dynamodb:DescribeStream",
        "dynamodb:DescribeTable",
        "dynamodb:Get*",
        "dynamodb:Query",
        "dynamodb:Scan",
        "dynamodb:DeleteItem",
        "dynamodb:UpdateItem",
        "dynamodb:PutItem"
    ]
    resources = [
      aws_dynamodb_table.dynamodb-kutter-table.arn
        ]
  }
}