# resource "aws_key_pair" "ssh_key_pair" {
#   key_name   = var.key_pair_name
#   public_key = file(var.public_key_path)
# }

data "aws_key_pair" "ssh_key_pair" {
  key_name           = var.data_kp_name
  include_public_key = true
}

resource "aws_instance" "ec2" {
  ami           = var.ami
  instance_type = var.ec2_instance_type
  key_name               = data.aws_key_pair.ssh_key_pair.key_name
  # key_name               = aws_key_pair.ssh_key_pair.key_name
  subnet_id              = var.subnet_id
  count                  = var.no_ec2_instances
  vpc_security_group_ids = var.ec2_security_group_lst
  iam_instance_profile = var.ec2_instance_profile_name

  user_data = var.ec2_script

  tags = {
    Name = "${var.project_name}-ec2-${var.ec2_type}-instance-${count.index}"
    Environment = var.environment
  }
}

