module "vpc" {
  source              = "../../../modules/vpc"
  environment         = "DEV"
  project_name        = "mb-terraform"
  vpc_cdir            = "10.0.0.0/16"
  public_subnet_cdir  = ["10.0.1.0/24"]
  no_private_subnets  = 2
  private_subnet_cdir = ["10.0.2.0/24", "10.0.3.0/24"]
}