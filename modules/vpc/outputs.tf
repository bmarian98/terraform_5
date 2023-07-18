output "vpc_id" {
  description = "Get vpc id"
  value       = aws_vpc.vpc.id
}

output "private_subnets" {
  value = aws_subnet.private_subnets[*]
}

output "public_subnets" {
  value = aws_subnet.public_subnets[*]
}

output "public_security_group" {
  value = aws_security_group.sec_group.id
}