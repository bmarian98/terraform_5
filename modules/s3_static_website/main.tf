resource "aws_s3_bucket" "s3_static_website" {
  bucket = var.s3_name
  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Name = var.s3_bucket_tag
    Environment = var.environment
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.s3_static_website.bucket
  key = "index.html"
  #source = "html/index.html"
  source = "../../../live/static_website/index.html"
  content_type = "text/html"
  etag = md5(var.index_file_path)
  #acl = "public-read"
}

resource "aws_s3_bucket_object" "error" {
  bucket = aws_s3_bucket.s3_static_website.bucket
  key = "error.html"
  #source = "html/error.html"
  source = "../../../live/static_website/index.html"
  content_type = "text/html"
  etag = md5(var.error_file_path)
  #acl = "public-read"
}