variable "environment"{
    default = "dev"
    type = string
}

variable "rds_ingress_port"{
    default = 3306
    type = number
}

variable "rds_ingress_protocol" {
  default = "tcp"
  type = string
}

variable "rds_egress_port" {
  default = 0
  type = number
}

variable "rds_egress_protocol"{
    default ="-1"
}

variable "rds_engine" {
  default = "mysql"
  type = string
}

variable "rds_identifier"{
    default = "mysql_instance"
    type = string
}

variable "rds_allocated_storage"{
    default = 8
    type = number
}

variable "engine_version"{
    default = "5.7"
    type = string
}

variable "rds_instance_class"{
    default = "db.t2.micro"
    type = string
}

variable "rds_user"{
    default = "mysqluser"
    type = string
}

variable "rds_pass"{
    default = "pass@1234"
    type = string
}

variable "rds_db_name" {
    default = "test"
    type = string
  
}

variable "rds_parameter_gr_name"{
    default = "default.mysql5.7"
    type = string
}

variable "rds_skip_final_snapshot"{
    default = true
    type = bool
}

variable "rds_publicly_accessible"{
    default = true
    type = bool
}