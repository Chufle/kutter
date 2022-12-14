resource "aws_s3_bucket" "nfish-des-kutter-upload" {
  bucket = "${var.bucketname-upload}"

  tags = {
    Name        = "${var.bucketname-upload}"
  }
}

resource "aws_s3_bucket" "nfish-des-kutter-store" {
  bucket = "${var.bucketname-store}"

  tags = {
    Name        = "${var.bucketname-store}"
  }
}
