output "ec2_instace_ids"{
    value = aws_instance.ec2[*].id
}

output "ec2_private_ip"{
    value = aws_instance.ec2[*].private_ip
}

output "ec2_script_content" {
  value = aws_instance.ec2[0].user_data
}