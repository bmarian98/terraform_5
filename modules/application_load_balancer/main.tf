resource "aws_lb_target_group" "alb_tg" {
  health_check{
    interval = var.alb_interval
    path = var.alb_path
    protocol = var.alb_protocol
    timeout = var.alb_timeout
    healthy_threshold = var.alb_healthy_threshold
    unhealthy_threshold = var.alb_unhealthy_threshold
  }

  name = var.alb_tg_name
  port = var.alb_port
  protocol = var.alb_protocol
  target_type = var.alb_target_type
  vpc_id = var.vpc_id
}

# Create ALB
resource "aws_lb" "alb"{
    name = var.alb_name
    internal = var.alb_internal
    ip_address_type = var.alb_ipa_type
    load_balancer_type =  var.alb_type
    security_groups = var.alb_security_groups
    subnets = var.alb_subnets_id

    tags = {
        Name = var.alb_tag
        Environment = var.environment
    }
}

# Create Listener
resource "aws_lb_listener" "alb_listener"{
    load_balancer_arn = aws_lb.alb.arn
    port  = var.alb_port
    protocol = var.alb_protocol
    
    default_action{
        target_group_arn = aws_lb_target_group.alb_tg.arn
        type = var.alb_listener_type
    }
}

# Attachment
resource "aws_lb_target_group_attachment" "alb_tg_attachment"{
    count = length(var.alb_tg_ec2_instance_ids)
    target_group_arn = aws_lb_target_group.alb_tg.arn
    target_id = var.alb_tg_ec2_instance_ids[count.index]
}