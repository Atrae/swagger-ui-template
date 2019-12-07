variable "region" { default = "ap-northeast-1" }
variable "bucket_name" { default = "swagger-docs" }
variable "allow_ip" { default =  [ "0.0.0.0" ] }

provider "aws" {
  region = var.region
}

data "aws_iam_policy_document" "bucket_policy_document" {
  statement {
    sid    = "IPAllow"
    effect = "Allow"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.main.id}/index.html",
    ]
    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values = var.allow_ip
    }
  }
}

resource "aws_s3_bucket" "main" {
  region = var.region
  bucket = var.bucket_name
  acl    = "private"
  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.bucket_policy_document.json
}
