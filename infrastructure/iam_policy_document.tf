data "aws_iam_policy_document" "iam_pol_doc_for_lambda" {
  statement {
    actions = [
        "s3-object-lambda:Get*",
        "s3-object-lambda:PutObject",
        "s3-object-lambda:DeleteObject"
    ]
    resources = [
        "arn:aws:s3:::${local.bucketname-photos}"
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
        "arn:aws:dynamodb:us-west-2:${data.aws_caller_identity.current.account_id}:table/kutter-table"
    ]
  }
}