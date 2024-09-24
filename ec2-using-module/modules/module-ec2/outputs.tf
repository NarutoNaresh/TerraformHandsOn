output "public_DNS_of_EC2" {
  value = aws_instance.EC2-sample1-TF.public_dns
}
