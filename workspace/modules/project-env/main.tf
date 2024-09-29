provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "name" {
  cidr_block = var.vpc-cidr-block
}


resource "aws_subnet" "name" {
  vpc_id                  = aws_vpc.name.id
  cidr_block              = var.subnet-cidr
  availability_zone       = var.region
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
  public_key = file(var.public-key-path)
  key_name   = var.key-name
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
  ami                    = var.ami
  instance_type          = var.ec2-type
  key_name               = aws_key_pair.name.key_name
  vpc_security_group_ids = [aws_security_group.name.id]
  # security_groups = [aws_security_group.name.id]
  subnet_id = aws_subnet.name.id

  user_data = file(var.ec2-user-data)

  connection {
    host        = self.public_ip
    user        = "ubuntu"
    type        = "ssh"
    private_key = file(var.private-key-path)
  }
  #   provisioner "file" {
  #     source      = "config.sh"
  #     destination = "/home/ubuntu/config.sh"
  #   }

  #   provisioner "remote-exec" {
  #     inline = ["sudo systemctl start nginx"]
  #   }
}

