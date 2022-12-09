data "aws_iam_policy_document" "iam_pol_doc_for_lambda" {
  statement {
    actions = [
      "s3:*",
      "s3-object-lambda:*"
    ]
    resources = [
      "*"
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