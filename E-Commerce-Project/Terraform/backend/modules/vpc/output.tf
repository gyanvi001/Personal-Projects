
output "vpc_id" {
  description = "VPC ID"
  value = aws_vpc.vpc1.id
  
}

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
    description = "Private Subnet IDs"
    value = aws_subnet.private[*].id
}