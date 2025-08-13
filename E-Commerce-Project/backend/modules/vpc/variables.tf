variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type = string
}

variable "private_subnet_cidrs" {
    description = "CIDR block for the private subnets"
    type = list(string)
    }

variable "public_subnet_cidrs" {
    description = "CIDR block for the public subnets"
    type = list(string)
    }

variable "availability_zones" {
    description = "Availability zones for the subnets"
    type = list(string)
}

variable "cluster_name" {
    description = "Name of the EKS clusters"
    type = string
}