resource "aws_s3_bucket" "s3" {
  bucket = var.s3_name
  tags = {
    Name = var.s3_bucket_tag
    Environment = var.environment
  }
}

# resource "aws_s3_bucket_object" "s3_object" {
#   for_each = [ "value" ]
# }