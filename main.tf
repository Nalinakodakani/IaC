# Provider Configuration (AWS)
provider "aws" {
  region = "us-east-1" # Change to your desired region
}

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create public and private subnets
resource "aws_subnet" "public_subnet" {
  count = 2
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.${100 + count.index}/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet" {
  count = 2
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.${100 + count.index}/24"
  availability_zone = "us-east-1b"
}

# Create security groups
resource "aws_security_group" "web_sg" {
  name_prefix = "web-"
  vpc_id = aws_vpc.my_vpc.id
  // Define inbound/outbound rules for web tier
  # ...
}

# Create EC2 instances for each tier
resource "aws_instance" "web_instance" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet[0].id
  security_groups = [aws_security_group.web_sg.id]
  # ...
}

# You can define more resources for application and database tiers here
