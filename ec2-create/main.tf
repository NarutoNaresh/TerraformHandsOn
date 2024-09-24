provider "aws" {
  region = "us-east-1"
}

# resource "aws_instance" "ec2-1" {
#   ami           = "ami-0e86e20dae9224db8"
#   instance_type = "t2.micro"
#   user_data     = file("nginx-demo-setup.sh")
#   tags = {
#     Name = "EC2-BY-TF"
#   }
# }

# output "ec2-ip" {
#   value = aws_instance.ec2-1.public_ip
# }

resource "aws_key_pair" "name" {
  public_key = file("C:\\Users\\NARESH DANIEL .LAPTOP-16702FGF\\.ssh\\id_rsa.pub")
  key_name   = "sample-key"
}

resource "aws_instance" "name" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.name.key_name
  user_data     = file("C:\\Users\\NARESH DANIEL .LAPTOP-16702FGF\\Documents\\0Terraform_learn\\ec2-create\\testfolder\\nginx-demo-setup.sh")
  tags = {
    "Name" : "EC2-Terraform"
  }
  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = file("C:\\Users\\NARESH DANIEL .LAPTOP-16702FGF\\.ssh\\id_rsa")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "abc.txt"
    destination = "/home/ubuntu/abc.txt"
  }

  provisioner "remote-exec" {
    inline = ["sudo systemctl start nginx"]
  }
}

# resource "aws_security_group" "terraform-sg" {
#   ingress {
#     description = "HTTP from VPC"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
