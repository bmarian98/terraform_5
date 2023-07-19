variable "s3_name" {
  default = "s3_bucket"
}

variable "environment" {
  default = "dev"
}

variable "s3_bucket_tag" {
  default = "s3_bucket"
}

variable "index_file_path"{
  type = string
}

variable "error_file_path"{
  type = string
}