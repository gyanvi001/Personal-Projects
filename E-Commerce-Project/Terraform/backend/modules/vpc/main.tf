
provider "aws" {
    region =  "us-west-2"
  
}

resource "aws_vpc" "vpc1" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    #tags play important role in identifying the resources and cost-optimisation
    tags = {
        Name                                                 = "${var.cluster_name}-vpc"
        "kubernetes.io/cluster/${var.cluster_name}"          = "shared"

    }
    
}

#Creating private subnet
resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.vpc1.id 
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = var.availability_zones[count.index]

    tags = {
      Name                                                   = "${var.cluster_name}-private-${count.index + 1}"
       "kubernetes.io/cluster/${var.cluster_name}"           = "shared"
    }
}

#Creating public subnet
resource "aws_subnet" "public" {
    count =length(var.public_subnet_cidrs)
    vpc_id = aws_vpc.vpc1.id
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = var.availability_zones[count.index]
    map_public_ip_on_launch = true

    tags = {
      Name                                                   = "${var.cluster_name}-public-${count.index + 1}"
       "kubernetes.io/cluster/${var.cluster_name}"           = "shared"
    }
  
}

#Creating internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc1.id
    tags = {
        Name = "${var.cluster_name}-igw"
    }
}

#Create route table - Check again
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.vpc1.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "${var.cluster_name}-public"
    }

}

#Associating route table with public subnet
resource "aws_route_table_association" "public" {
    count = length(var.public_subnet_cidrs)
    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}


# Allocate Elastic IPs for the NAT Gateway
resource "aws_eip" "nat" {
    count = length(var.public_subnet_cidrs)

    tags = {
        Name = "${var.cluster_name}-nat-eip-${count.index + 1}"
    }
}

#Creating Nat gateway
resource "aws_nat_gateway" "name" {
    count = length(var.public_subnet_cidrs)
    allocation_id = aws_eip.nat[count.index].id
    subnet_id = aws_subnet.public[count.index].id
    tags = {
        Name = "${var.cluster_name}-nat-${count.index + 1}"
    }
  
}

#Craete route table private
resource "aws_route_table" "private" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.vpc1.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.name[count.index].id

    }
    tags = {
        Name = "${var.cluster_name}-private-${count.index + 1}"
    }
}

#Associating route table with private subnet
resource "aws_route_table_association" "private" {
    count = length(var.private_subnet_cidrs)
    subnet_id = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private[count.index].id
}