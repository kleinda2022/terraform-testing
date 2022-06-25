provider "aws" {
  region     = "us-east-1"
}

variable "subnet_cidr_block" {
  description = "subnet cidr block"

}

variable "vpc_cidr_block" {
  description = "vpc cidr block"

}

resource "aws_vpc" "dev-vpc1" {
  cidr_block = var.vpc_cidr_block
  tags = {
    "Name" = "dev"
  }

}

resource "aws_subnet" "dev-subnet1" {
  vpc_id            = aws_vpc.dev-vpc1.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "dev"
  }

}

data "aws_vpc" "existing-vpc" {
  default = true
}

resource "aws_subnet" "dev-subnet2" {
  vpc_id            = data.aws_vpc.existing-vpc.id
  cidr_block        = "172.31.16.0/20"
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "dev-d"
  }
}

output "dev-vpc-id" {
  value = aws_vpc.dev-vpc1.id

}

output "aws_subnet-id" {
  value = aws_subnet.dev-subnet1.id

}



 