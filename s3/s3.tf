provider "aws" {
  region     = "us-east-2"
  access_key = "AKIAI2LGBHRGPKSMWFPQ"
  secret_key = "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"
}


resource "aws_s3_bucket" "b" {

    bucket = "yash4993bucket"

    acl    = "private"

}


resource "aws_s3_bucket_object" "folder1" {

    bucket = aws_s3_bucket.b.bucket

    acl    = "private"

    key    = "Folder1/"

    source = "/dev/null"

}
