resource "aws_s3_bucket" "nfish-des-kutter-photos" {
  bucket = "${local.bucketname-photos}"

  tags = {
    Name        = "${local.bucketname-photos}"
  }
}
