variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "availability_zone" {
  default = "us-east-1"
}

variable "vpc_id" {
  description = "VPC ID information for TF servers."
}

variable "subnet_id" {
  description = "Subnet ID information for the Web servers."
}