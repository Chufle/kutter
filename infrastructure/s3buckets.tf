resource "aws_s3_bucket" "nfish-des-kutter-upload" {
  bucket = "${local.bucketname-upload}"

  tags = {
    Name        = "${local.bucketname-upload}"
  }
}

resource "aws_s3_bucket" "nfish-des-kutter-store" {
  bucket = "${local.bucketname-store}"

  tags = {
    Name        = "${local.bucketname-store}"
  }
}