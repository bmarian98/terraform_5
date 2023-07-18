# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cdir
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.project_name}-${var.environment}-vpc"
    Environment = var.environment
  }
}

# Get availibility zones
data "aws_availability_zones" "az" {}

# Create public subnet
resource "aws_subnet" "public_subnets" {
  depends_on = [
    aws_vpc.vpc
  ]

  vpc_id                  = aws_vpc.vpc.id
  count                   = var.no_public_subnets
  cidr_block              = var.public_subnet_cdir[count.index]
  availability_zone = element(data.aws_availability_zones.az.names, count.index)
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.project_name}-${var.environment}-pulic-subnet-${count.index}"
    Environment = var.environment
  }
}

# Create private subnets
resource "aws_subnet" "private_subnets" {
  depends_on = [
    aws_vpc.vpc
  ]

  vpc_id     = aws_vpc.vpc.id
  count      = var.no_private_subnets
  cidr_block = var.private_subnet_cdir[count.index]
  availability_zone = element(data.aws_availability_zones.az.names, count.index)

  tags = {
    Name = "${var.project_name}-${var.environment}-private-subnet-${count.index}"
    Environment = var.environment
  }
}

# Create IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  depends_on = [

      aws_vpc.vpc,
      aws_subnet.public_subnets,
      aws_subnet.private_subnets

    ]
  tags = {
    Name = "${var.project_name}-${var.environment}-igw"
    Environment = var.environment
  }
}

# Create route table
resource "aws_route_table" "rt" {
  depends_on = [
    aws_vpc.vpc,
    aws_internet_gateway.igw
  ]

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-rt"
  }
}

# Associate Route table
resource "aws_route_table_association" "rt" {
  depends_on = [
    aws_vpc.vpc,
    aws_subnet.public_subnets,
    aws_subnet.private_subnets,
    aws_route_table.rt
  ]
  count          = var.no_public_subnets
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.rt.id

}
# resource "aws_route_table_association" "private" {
#   count          = var.no_public_subnets
#   subnet_id      = aws_subnet.private_subnets[count.index].id
#   route_table_id = aws_route_table.rt.id
# }

# Creating an Elastic IP for the NAT Gateway!
resource "aws_eip" "eip" {
  depends_on = [ aws_route_table_association.rt ]
  vpc = true
}

# Create NAT GW
resource "aws_nat_gateway" "nat_gw" {
  depends_on = [
    aws_eip.eip
  ]

  # Allocating the Elastic IP to the NAT Gateway!
  allocation_id = aws_eip.eip.id

  # Associating it in the Public Subnet!
  subnet_id = aws_subnet.public_subnets[0].id
  tags = {
    Name = "${var.project_name}-${var.environment}-nat-gw"
    Environment = var.environment
  }
}

# Creating a Route Table for the Nat Gateway!
resource "aws_route_table" "nat_gw_rt" {
  depends_on = [
    aws_nat_gateway.nat_gw
  ]
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-nat-gw-rt"
    Environment = var.environment
  }
}

# Creating an Route Table Association of the NAT Gateway route 
# table with the Private Subnet!
# resource "aws_route_table_association" "nat_gw_rt_association_public" {
#   depends_on = [
#     aws_route_table.nat_gw_rt
#   ]

#   count     = var.no_public_subnets
#   subnet_id = aws_subnet.public_subnets[count.index].id

#   # Route Table ID
#   route_table_id = aws_route_table.nat_gw_rt.id
# }

resource "aws_route_table_association" "nat_gw_rt_association_private" {

  count     = var.no_private_subnets
  subnet_id = aws_subnet.private_subnets[count.index].id

  # Route Table ID
  route_table_id = aws_route_table.nat_gw_rt.id
}

# Security group
resource "aws_security_group" "sec_group" {
  depends_on = [
    aws_vpc.vpc,
    aws_subnet.public_subnets,
    aws_subnet.private_subnets
  ]

  name = "terraform-example-instance"

  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}