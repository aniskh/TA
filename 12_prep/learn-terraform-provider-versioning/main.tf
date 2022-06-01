provider "aws" {
  region = "eu-west-3"
}

resource "random_pet" "petname" {
  length    = 5
  separator = "-"
}

resource "aws_s3_bucket" "sample" {
  bucket = random_pet.petname.id

  #acl    = "public-read"
  #region = "eu-west-3"

  tags = {
    public_bucket = true
  }
}
resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.sample.id
  acl    = "public-read"
}
