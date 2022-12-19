resource "aws_dynamodb_table" "dynamodb-kutter-table" {
  name     = "kutter-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key = "objectId"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
      name = "objectId"
      type = "S"
  }
}
