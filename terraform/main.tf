provider "aws" {
  region     = "us-east-1"
}

data "aws_ami" "ubuntu_latest" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  
  owners = ["099720109477"] # Canonical
  
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_vpc" "ubuntu_vpc" {
  cidr_block = "10.10.0.0/16"
}

resource "aws_subnet" "ubuntu_subnet" {
  vpc_id            = aws_vpc.ubuntu_vpc.id
  cidr_block        = "10.10.10.0/24"
  availability_zone = "us-east-1"
}

resource "aws_network_interface" "ubuntu_ni" {
  subnet_id   = aws_subnet.ubuntu_subnet.id
  private_ips = ["10.10.10.101"]
}

resource "aws_instance" "ec2_ubuntu" {
  ami           = data.aws_ami.ubuntu_latest.id
  instance_type = "t2.micro"
  network_interface {
    network_interface_id = aws_network_interface.ubuntu_ni.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    Name = "Ubuntu_Latest"
  }
}
