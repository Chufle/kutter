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
  name        = "nfish-des-role-lambda_s3_access"
  description = "access to s3 for lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "nfish-des-lambda_s3_access" {
  role       = aws_iam_role.nfish-des-role-lambda_s3_access.name
  policy_arn = aws_iam_policy.nfish-des-pol-lambda_s3_access.arn
}