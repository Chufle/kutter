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

resource "aws_s3_bucket" "nfish-des-kutter-lb-logs" {
  bucket = "${local.bucketname-lb-logs}"

  tags = {
    Name        = "${local.bucketname-lb-logs}"
  }
}