resource "aws_security_group" "rds_sg" {
  name = "rds_sg"
  ingress {
    from_port       = var.rds_ingress_port
    to_port         = var.rds_ingress_port
    protocol        = var.rds_ingress_protocol
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = var.rds_egress_port
    to_port     = var.rds_egress_port
    protocol    = var.rds_egress_protocol
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_db_subnet_group" "db_subnet_group" {
#   name       = "main"
#   subnet_ids = [aws_subnet.frontend.id, aws_subnet.backend.id]

#   tags = {
#     Name = "My DB subnet group"
#     Environment = var.environment
#   }
# }

#create a RDS Database Instance
resource "aws_db_instance" "db_instance" {
  engine               = var.rds_engine
  identifier           = var.rds_identifier
  allocated_storage    =  var.rds_allocated_storage
  engine_version       = var.engine_version
  instance_class       = var.rds_instance_class
  username             = var.rds_user
  password             = var.rds_pass
  db_name = var.rds_db_name
  # db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  parameter_group_name = var.rds_parameter_gr_name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot  = var.rds_skip_final_snapshot
  publicly_accessible =  var.rds_publicly_accessible

  tags = {
    Environment = var.environment
  }

}