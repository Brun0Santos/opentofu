provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "opentofu_supera_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc_supera"
  }
}

resource "aws_subnet" "supera_subnet1" {
  vpc_id            = aws_vpc.opentofu_supera_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet_1_supera"
  }
}

#resource "aws_subnet" "supera_subnet2" {
#  vpc_id            = aws_vpc.opentofu_supera_vpc.id
#  cidr_block        = "10.0.2.0/24"
#  availability_zone = "us-east-1a"
#  tags = {
#    Name = "subnet_2_supera"
#  }
#}

resource "aws_security_group" "opentofu_supera_sg" {
  name        = "opentofu_supera_sg"
  description = "Security group for OpenTofu instances"
  vpc_id      = aws_vpc.opentofu_supera_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "supera_opentofu_instance1" {
  ami                    = "ami-0f403e3180720dd7e"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.supera_subnet1.id
  vpc_security_group_ids = [aws_security_group.opentofu_supera_sg.id]
}

#resource "aws_instance" "supera_opentofu_instance2" {
#  ami                    = "ami-0f403e3180720dd7e"
#  instance_type          = "t2.micro"
#  subnet_id              = aws_subnet.supera_subnet2.id
#  vpc_security_group_ids = [aws_security_group.opentofu_supera_sg.id]
#}