provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "opentofu_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc_opentofu"
  }
}

resource "aws_subnet" "opentofu_subnet1" {
  vpc_id            = aws_vpc.opentofu_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet_1_example"
  }
}

resource "aws_internet_gateway" "opentofu_igw" {
  vpc_id = aws_vpc.opentofu_vpc.id

  tags = {
    Name = "opentofu_igw"
  }
}

resource "aws_route_table" "opentofu_rt" {
  vpc_id = aws_vpc.opentofu_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.opentofu_igw.id
  }

  tags = {
    Name = "opentofu_rt"
  }
}

resource "aws_route_table_association" "opentofu_rta" {
  subnet_id      = aws_subnet.opentofu_subnet1.id
  route_table_id = aws_route_table.opentofu_rt.id
}

resource "aws_security_group" "opentofu_sg" {
  name        = "opentofu_sg"
  description = "Security Group"
  vpc_id      = aws_vpc.opentofu_vpc.id

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
  subnet_id              = aws_subnet.opentofu_subnet1.id
  vpc_security_group_ids = [aws_security_group.opentofu_sg.id]
  key_name               = "chave-ssh-opentofu"
  tags = {
    Name = "instance_tofu"
  }
}

output "instance_ip" {
  value = aws_instance.supera_opentofu_instance1.public_ip
}