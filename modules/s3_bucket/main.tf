resource "aws_s3_bucket" "s3" {
  bucket = var.s3_name
  tags = {
    Name = var.s3_bucket_tag
    Environment = var.environment
  }
}

resource "null_resource" "download_zip_from_GitHub" {
  provisioner "local-exec" {
    command = "curl -L -o ${var.zip_name}.zip ${var.git_repo_url}"
  }

  depends_on = [ 
    aws_s3_bucket.s3
   ]
}

resource "aws_s3_bucket_object" "s3_object" {
  bucket = aws_s3_bucket.s3.bucket
  key    = "${var.zip_name}.zip"
  source = "${var.local_zip_file_path}/${var.zip_name}.zip"

  # Depend on the null_resource to ensure it runs before uploading the zip file to S3
  depends_on = [
    null_resource.download_zip_from_GitHub
  ]
}

resource "null_resource" "delete_zip_file" {
  provisioner "local-exec" {
    command = "rm ${var.zip_name}.zip"
  }

  depends_on = [ 
    aws_s3_bucket_object.s3_object
   ]
}