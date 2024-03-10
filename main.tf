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
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet_1_supera"
  }
}

resource "aws_internet_gateway" "opentofu_supera_igw" {
  vpc_id = aws_vpc.opentofu_supera_vpc.id

  tags = {
    Name = "opentofu_supera_igw"
  }
}

resource "aws_route_table" "opentofu_supera_rt" {
  vpc_id = aws_vpc.opentofu_supera_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.opentofu_supera_igw.id
  }

  tags = {
    Name = "opentofu_supera_rt"
  }
}

resource "aws_route_table_association" "opentofu_supera_rta" {
  subnet_id      = aws_subnet.supera_subnet1.id
  route_table_id = aws_route_table.opentofu_supera_rt.id
}

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
  tags = {
    Name = "instance_tofu_supera"
  }
}

output "instance_ip" {
  value = aws_instance.supera_opentofu_instance1.public_ip
}