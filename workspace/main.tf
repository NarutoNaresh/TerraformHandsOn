provider "aws" {
  region = "us-east-1"
}
variable "vpc-cidr-block" { description = "add value in tfvars" }
variable "subnet-cidr" { description = "add value in tfvars" }
variable "region" { description = "add value in tfvars" }
variable "ami" { description = "add value in tfvars" }
variable "ec2-type" { description = "add value in tfvars" }
variable "public-key-path" { description = "add value in tfvars" }
variable "private-key-path" { description = "add value in tfvars" }
variable "ec2-user-data" { description = "add value in tfvars" }
variable "key-name" { description = "add value in tfvars" }


module "Environment-setup" {
  source           = "./modules/project-env"
  region           = var.region
  vpc-cidr-block   = var.vpc-cidr-block
  subnet-cidr      = var.subnet-cidr
  ami              = var.ami
  key-name         = var.key-name
  private-key-path = var.private-key-path
  public-key-path  = var.public-key-path
  ec2-type         = var.ec2-type
  ec2-user-data    = var.ec2-user-data
}

output "Ec2-IP" {
  value = module.Environment-setup.Ec2-ip
}
