variable "db_pass" {
  sensitive = true
}
variable "db_user" {}

module "rds_mysql" {
  source         = "../../../modules/RDS"
  environment    = "DEV"
  rds_user       = var.db_user
  rds_pass       = var.db_pass
  rds_identifier = "mb-mysql"
}