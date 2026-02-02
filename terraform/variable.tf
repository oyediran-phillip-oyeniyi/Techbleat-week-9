variable "vpc" {
  description = "Parent VPC"
  type        = string
}

variable "ami" {
  description = "ami name"
  type        = string
}

variable "project_subnet" {
    type = string
    description = "Subnet address"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}
