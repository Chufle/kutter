resource "aws_s3_bucket" "nfish-des-kutter-photos" {
  bucket = "nfish-des-kutter-photos"

  tags = {
    Name        = "nfish-des-kutter-photos"
  }
}