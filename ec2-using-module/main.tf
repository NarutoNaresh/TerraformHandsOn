#while you modularized the resourse then do terraform init and terraform validate cmds

provider "aws" {
  region = "us-east-1"
}

module "ec2module" {
  #look all the fields are customised
  source        = "./modules/module-ec2"
  instance_type = "t2.micro"
  ami_id        = "ami-0e86e20dae9224db8"
  ec2_name      = "sample-name-a"
}
