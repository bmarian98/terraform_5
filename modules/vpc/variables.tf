# variable "terraform_version"{
#     description = "Sets the minimum required version"
#     type = string
# }

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

variable "vpc_cdir" {
  description = "Sets vpc cdir block"
  type        = string
}

# Public subnets vars
variable "no_public_subnets" {
  description = "Sets number of public subnets"
  type        = number
  default     = 1
}

variable "public_subnet_cdir" {
  description = "Sets public cdir block"
  type        = list(string)
}

# Private subnets var
variable "no_private_subnets" {
  description = "Sets number of private subnets"
  type        = number
  default     = 1
}

variable "private_subnet_cdir" {
  description = "Sets private cdir block"
  type        = list(string)
}

variable "rt_cdir_block" {
  description = "Sets route table cdir block"
  type        = string
  default     = "0.0.0.0/0"
}