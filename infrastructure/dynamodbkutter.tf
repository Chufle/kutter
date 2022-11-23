resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name     = "kutter-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key = "objectId"
  
  attribute {
      name = "objectId"
      type = "S"
  }
}
