terraform {
  backend "s3" {
    bucket = "phil-terraform-state-bucket"
    key = "env/dev-ansible/terraform.tfstate"
    region = "eu-west-1"
    encrypt = true
  }

    required_version = ">= 1.6.0"

    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}


provider "aws" {
    region = "eu-west-1"
}

#-------------------------------------
# Nginx Node Security Group
#-------------------------------------

resource "aws_security_group" "nginx-sg" {
  name = "nginx-sg"
  description = "Allow SSH and Port 80 inbound, all outbound"
  vpc_id = var.vpc

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Nginx-security-group"
  }
}

#-------------------------------------
# Nginx Node Instance
#-------------------------------------

resource "aws_instance" "nginx-node" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.project_subnet
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  key_name               = var.key_name

  tags = {
    Name = "Nginx-node"
    Type = "Nginx"
  }
}

#-------------------------------------
# Java Node Security Group
#-------------------------------------

resource "aws_security_group" "java-sg" {
  name = "java-sg"
  description = "Allow SSH and Port 80 inbound, all outbound"
  vpc_id = var.vpc

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Java-security-group"
  }
}

#-------------------------------------
# Java Node Instance 
#-------------------------------------

resource "aws_instance" "java-node" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.project_subnet
  vpc_security_group_ids = [aws_security_group.java-sg.id]
  key_name               = var.key_name

  tags = {
    Name = "Java-node"
    Type = "Java"
  }
}

#-------------------------------------
# Ansible Node Security Group
#-------------------------------------

resource "aws_security_group" "ansible-sg" {
  name = "ansible-sg"
  description = "Allow SSH and Port 80 inbound, all outbound"
  vpc_id = var.vpc

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Ansible-security-group"
  }
}

#-------------------------------------
# Nginx Node Instance
#-------------------------------------

resource "aws_instance" "ansible-node" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.project_subnet
  vpc_security_group_ids = [aws_security_group.ansible-sg.id]
  key_name               = var.key_name

  tags = {
    Name = "Ansible-node"
    Type = "Ansible"
  }
}
