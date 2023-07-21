/* 
data "aws_iam_instance_profile" "instance_profile" {
  name = "MBSSMEC2InstanceProfile"
}

variable "db_pass" {
  sensitive = false
}
variable "db_user" {}
variable "db_url" {}
variable "s3_app" {}

data "template_file" "private_ec2_user_data" {
  template = file("../../scripts/docker_backend_server.sh")
  vars = {
    db_user = var.db_user
    db_pass = var.db_pass
    db_url  = var.db_url
    s3_app  = var.s3_app
  }
}

data "template_file" "public_ec2_user_data" {
  template = file("../../scripts/install_nginx.sh")
  vars = {
    web_server_ip   = module.private_ec2.ec2_private_ip[0]
    web_server_port = "8080"
  }
}

module "vpc" {
  source = "../network"
}


module "public_ec2" {
  source                    = "../../../modules/ec2_instance"
  environment               = "PROD"
  project_name              = "mb-terraform"
  key_pair_name             = "public_ec2_key"
  public_key_path           = "/Users/marianbodnar/.ssh/id_rsa.pub"
  subnet_id                 = module.vpc.public_subnets[0].id
  data_kp_name              = "mb-internship-ssh-kp"
  ec2_security_group_lst    = [module.vpc.public_security_group]
  ec2_script                = data.template_file.public_ec2_user_data.rendered
  ec2_type                  = "bastion"
  ec2_instance_profile_name = data.aws_iam_instance_profile.instance_profile.name
}

module "private_ec2" {
  source                    = "../../../modules/ec2_instance"
  environment               = "PROD"
  project_name              = "mb-terraform"
  key_pair_name             = "public_ec2_key"
  public_key_path           = "/Users/marianbodnar/.ssh/id_rsa.pub"
  subnet_id                 = module.vpc.private_subnets[0].id
  data_kp_name              = "mb-internship-ssh-kp"
  ec2_script                = data.template_file.private_ec2_user_data.rendered
  ec2_security_group_lst    = [module.vpc.public_security_group]
  ec2_instance_profile_name = data.aws_iam_instance_profile.instance_profile.name
}

module "alb" {
  source       = "../../../modules/application_load_balancer"
  environment  = "PROD"
  project_name = "mb-terraform"
  alb_tg_name  = "mb-alb"
  vpc_id       = module.vpc.vpc_id
  alb_name     = "mb-app-lb"
  alb_subnets_id = [module.vpc.public_subnets[0].id,
  module.vpc.private_subnets[1].id]
  alb_tg_ec2_instance_ids = module.public_ec2.ec2_instace_ids
  alb_security_groups     = [module.vpc.public_security_group]
} */

/* module "s3" {
  source        = "../../../modules/s3_bucket"
  environment   = "PROD"
  s3_name       = "mb-s3-bucket-prod"
  s3_bucket_tag = "mb-s3"

}  */


module "s3_static_website" {
  source        = "../../../modules/s3_static_website"
  environment   = "PROD"
  s3_name       = "student-mb-s3-bucket-98"
  s3_bucket_tag = "mb-s3-98"
  index_file_path = file("../../static_website/index.html")
  error_file_path = file("../../static_website/error.html")
}