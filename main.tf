provider "aws" {
  region = var.availability_zone
}

resource "null_resource" "pp_application_docker_build" {
  provisioner "local-exec" {
    command = <<-EOF
      git clone https://github.com/wentworthm/pp_test.git
      cd pp_test
      docker build -t wentworthm/pp-test-fastapi-app:latest .
      docker push wentworthm/pp-test-fastapi-app:latest
    EOF
  }
}

resource "aws_instance" "pp_test_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.pp_test_sg.id]
  subnet_id              = var.subnet_id
  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo docker pull wentworthm/pp-test-fastapi-app:latest
    sudo docker run -d -p 80:80 wentworthm/pp-test-fastapi-app:latest
  EOF
}

resource "aws_security_group" "pp_test_sg" {
  name        = "pp-test-security-group"
  description = "Security Group for Web Server"
  vpc_id = var.vpc_id

  ingress {
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "443"
    to_port = "443"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

