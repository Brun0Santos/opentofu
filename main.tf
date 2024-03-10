provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "opentofu_supera_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "supera_subnet1" {
  vpc_id            = aws_vpc.opentofu_supera_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "supera_subnet2" {
  vpc_id            = aws_vpc.opentofu_supera_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_instance" "supera_opentofu_instance1" {
  ami           = "ami-0f403e3180720dd7e"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.supera_subnet1.id
}

resource "aws_instance" "supera_opentofu_instance2" {
  ami           = "ami-0f403e3180720dd7e"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.supera_subnet2.id
}