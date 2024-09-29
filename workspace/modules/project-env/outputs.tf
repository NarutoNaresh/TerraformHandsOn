output "Ec2-ip" {
  value = aws_instance.name.public_ip
}

output "vpc_id" {
  value = aws_vpc.name.id
}

output "subnet_id" {
  value = aws_subnet.name.id
}
