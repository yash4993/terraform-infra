provider "aws" {
  region     = "us-east-2"
  access_key = "somexyz"
  secret_key = "somexyz"
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
