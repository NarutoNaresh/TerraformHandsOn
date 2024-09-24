provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "name" {
  vpc_id                  = aws_vpc.name.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.name.id
}

resource "aws_route_table" "name" {
  vpc_id = aws_vpc.name.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
  }
}

resource "aws_route_table_association" "name" {
  route_table_id = aws_route_table.name.id
  subnet_id      = aws_subnet.name.id
}

resource "aws_key_pair" "name" {
  public_key = file("C:\\Users\\NARESH DANIEL .LAPTOP-16702FGF\\.ssh\\id_rsa.pub")
  key_name   = "My-key-Terraform"
}

resource "aws_security_group" "name" {
  vpc_id = aws_vpc.name.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "name" {
  ami                    = "ami-0e86e20dae9224db8"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.name.key_name
  vpc_security_group_ids = [aws_security_group.name.id]
  # security_groups = [aws_security_group.name.id]
  subnet_id = aws_subnet.name.id

  user_data = file("C:\\Users\\NARESH DANIEL .LAPTOP-16702FGF\\Documents\\0Terraform_learn\\dev-env\\nginx-demo-setup.sh")

  connection {
    host        = self.public_ip
    user        = "ubuntu"
    type        = "ssh"
    private_key = file("C:\\Users\\NARESH DANIEL .LAPTOP-16702FGF\\.ssh\\id_rsa")
  }

  provisioner "file" {
    source      = "config.sh"
    destination = "/home/ubuntu/config.sh"
  }

  provisioner "remote-exec" {
    inline = ["sudo systemctl start nginx"]
  }
}
