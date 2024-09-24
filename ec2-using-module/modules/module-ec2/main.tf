#while modularisin the resource, the tfvars files is not necessary.
#because variable inputs are directly passed in new main.tf file by the user
#if needed tfvars can be created by users i guess ;)

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "EC2-sample1-TF" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = var.ec2_name
  }
}

