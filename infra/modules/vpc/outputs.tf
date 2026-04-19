output "vpc_id" {
  description = "The VPC ID"
  value = aws_vpc.main.id
}

output "public_1_subnet" {
  description = "Public 1 Subnet ID"
  value = aws_subnet.public_1.id
}

output "public_2_subnet" {
  description = "Public 2 Subnet ID"
  value = aws_subnet.public_2.id
}

output "private_1_subnet" {
  description = "Private 1 Subnet ID"
  value = aws_subnet.private_1.id
}

output "private_2_subnet" {
  description = "Private 2 Subnet ID"
  value = aws_subnet.private_2.id
}