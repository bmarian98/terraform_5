resource "aws_s3_bucket" "s3" {
  bucket = var.s3_name
  tags = {
    Name = var.s3_bucket_tag
    Environment = var.environment
  }
}

resource "null_resource" "upload_zip_from_GitHub"{
  provisioner "local-exec" {
    command = "curl -L -o ${var.zip_name}.zip ${var.git_repo_url}"
  }

  provisioner "local-exec" {
    command = "aws s3 cp ${var.zip_name}.zip s3://${aws_s3_bucket.s3.bucket}"
  }

  depends_on = [ 
    aws_s3_bucket.s3
   ]
}


# resource "aws_s3_bucket_object" "s3_object" {
#   for_each = [ "value" ]
# }