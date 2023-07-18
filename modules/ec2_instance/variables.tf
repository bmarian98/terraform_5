variable "ec2_type" {
  default = "private"
  type = string
}

variable "region" {
  description = "Sets region where the resource is created"
  type        = string
  default     = "eu-center-1"
}

variable "project_name" {
  description = "Sets project name"
  type        = string
}

variable "environment" {
  description = "Sets environment name (dev/prod)"
  type        = string
}

# Key Pair vars
variable "key_pair_name" {
  description = "Sets name for EC2 key pair"
  type        = string
}

variable "public_key_path" {
  description = "Sets public key for EC2 from file path"
  type        = string
}

# EC2 vars
variable "no_ec2_instances" {
  description = "Sets number of EC2 instances"
  type        = number
  default     = 1
}

variable "ami" {
  description = "Sets ami type"
  type        = string
  default     = "ami-0d41b0174a816da7a" # Ubuntu 20.04 LTS 64-bit AMI ID for eu-central-1 region
}

variable "ec2_instance_type" {
  description = "Sets EC2 instacnce type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Sets subnet id for EC2 instacnce"
}

variable "data_kp_name" {
  description = "Sets name for key pair to import in data block"
  type        = string
}

variable "ec2_security_group_lst"{
  description = "Sets security group"
  #type = list(number)
}

variable "ec2_script"{
  description = "Sets path to the script that is used in EC2 user data"
  type = string
  default = ""
}

variable "ec2_instance_profile_name" {
  default = ""
  type = string
}