variable "s3_name" {
  default = "s3_bucket"
}

variable "environment" {
  default = "DEV"
}

variable "s3_bucket_tag" {
  default = "s3_bucket"
}

variable "git_repo_url"{
  type = string
}

variable "zip_name" {
  #default = "webapp.zip"
  type = string
}