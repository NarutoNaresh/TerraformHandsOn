variable "vpc-cidr-block" {
  # default = "10.0.0.0/16"
}

variable "subnet-cidr" {
  # default = "10.0.0.0/24"
}

variable "region" {
  # default = "us-east-1a"
}

variable "ami" {
  # default = "ami-0e86e20dae9224db8"
}

variable "ec2-type" {
  # default = "t2.micro"
}

variable "public-key-path" {
  # default = "C:\\Users\\NARESH DANIEL .LAPTOP-16702FGF\\.ssh\\id_rsa.pub"
}

variable "private-key-path" {
  # default = "C:\\Users\\NARESH DANIEL .LAPTOP-16702FGF\\.ssh\\id_rsa"
}


variable "ec2-user-data" {
  # default = "C:\\Users\\NARESH DANIEL .LAPTOP-16702FGF\\Documents\\0Terraform_learn\\dev-env\\nginx-demo-setup.sh"
}

variable "key-name" {
  # default = "My-key-Terraform"
}
