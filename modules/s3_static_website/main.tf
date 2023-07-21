resource "aws_s3_bucket" "s3_static_website" {
  bucket = var.s3_name
  /* website {
    index_document = "index.html"
    error_document = "error.html"
  } */

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
  acl = "public-read"
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


resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = aws_s3_bucket.s3_static_website.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::${var.s3_name}/*"
      }
    ]
  })
}

/* resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.s3_static_website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.s3_static_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
} */

resource "aws_s3_bucket_acl" "example" {
  /* depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ] */

  bucket = aws_s3_bucket.s3_static_website.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.s3_static_website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
/* 
  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  } */
}