data "aws_partition" "current" {}


# Create a VPC
resource "aws_vpc" "bibrani-vpc-us" {
  cidr_block           = "10.20.0.0/16" # Specify the VPC's CIDR block
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Create an Internet Gateway (IGW)
resource "aws_internet_gateway" "bibrani-igw-us" {
  vpc_id = aws_vpc.bibrani-vpc-us.id
}

# Create a public subnet
resource "aws_subnet" "bibrani-public-subnet-us" {
  vpc_id                  = aws_vpc.bibrani-vpc-us.id
  cidr_block              = "10.20.10.0/24" # Specify the public subnet's CIDR block
  availability_zone       = "us-east-1a"    # Set the desired availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "bibrani-public-subnet-us"
  }
}

# Create a Route Table for the public subnet
resource "aws_route_table" "bibrani-route-table" {
  vpc_id = aws_vpc.bibrani-vpc-us.id
}

# Create a route for the public subnet to the Internet Gateway
resource "aws_route" "public" {
  route_table_id         = aws_route_table.bibrani-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.bibrani-igw-us.id
}

resource "aws_route_table_association" "public_subnet_asso_bibrani" {
  subnet_id      = aws_subnet.bibrani-public-subnet-us.id
  route_table_id = aws_route_table.bibrani-route-table.id
}

################################
# Security Group
################

# Create a security group
resource "aws_security_group" "bibrani-sg-us" {
  name   = "bibrani-sg-us"
  vpc_id = aws_vpc.bibrani-vpc-us.id

  # Define inbound and outbound rules
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["111.95.57.56/32","114.4.200.222/32"] # Allow SSH access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

################################################################################
# Instance
################################################################################

resource "aws_instance" "this" {
  count = length(var.instance_config)

  ami           = var.ami
  instance_type = var.instance_config[count.index].instance_type

  availability_zone      = var.availability_zone
  subnet_id              = aws_subnet.bibrani-public-subnet-us.id
  vpc_security_group_ids = [aws_security_group.bibrani-sg-us.id]


  key_name             = var.key_name
  iam_instance_profile = "bibrani-s3-benchmark-report"

  # Define the root EBS volume with size and type
  root_block_device {
    volume_size = 100  # Specify the desired disk size in GiB
    volume_type = "gp3"  # Specify the desired volume type (e.g., gp2, io1, etc.)
  }


  tags = {
    Name = var.instance_config[count.index].tag_name
  }

  user_data = <<-EOF
              #!/bin/bash
              apt install -y awscli
              EOF

}
