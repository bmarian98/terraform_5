variable "environment"{
    default = "dev"
    type = string
}

variable "project_name"{
    type = string
}

variable "alb_tg_name"{
    default = "alb-tg"
    type = string
}

variable "alb_protocol"{
    default = "HTTP"
    type = string
}

variable "alb_interval"{
    default = 10
    type = number
}

variable "alb_timeout"{
    default = 5
    type = number
}

variable "alb_path"{
    default = "/"
    type = string
}

variable "alb_healthy_threshold"{
    default = 5
    type = number
}

variable "alb_unhealthy_threshold"{
    default = 2
    type = number
}


variable "alb_port"{
    default = 80
    type = number
}

variable "alb_target_type"{
    default = "instance"
    type = string
}

variable "vpc_id"{
    
}

variable "alb_name"{
    default = "alb-name"
    type = string
}

variable "alb_internal"{
    default = false
    type = bool
}

variable "alb_ipa_type" {
    default = "ipv4"
    type = string
}

variable "alb_type" {
    default = "application"
    type = string
}

variable "alb_security_groups" {
    default = []
    type = list(string)
}

variable "alb_subnets_id" {
    default = []
    type = list(string)
}

variable "alb_tag"{
    default = "alb-tag"
    type = string
}

variable "alb_listener_type"{
    default = "forward"
    type = string
}

variable "alb_tg_ec2_instance_ids"{
}