variable "vpc_cidr" {
  type = string 
  default = "10.0.0.0/16"

}



variable "availability_zones" {
  type = list(string)
  default = ["us-west-2a", "us-west-2b"]
  
}

variable "private_subnets_cidrs" {
  type = list(string)
  default = ["10.0.2.0/24", "10.0.3.0/24"] 
  
}

variable "public_subnets_cidrs" {
  type = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24"]
  
}

variable "cluster_name" {
  type = string
  default = "e-commerce-eks-cluster"

  
}

variable "cluster_version" {
  type = string
  default = "1.28"  
}

variable "node_groups" {
  type = map(object({
    instance_types   = list(string)    # Fix: Use string instead of list(string)
    capacity_type   = string
    scaling_config  = object({
      desired_size = number
      max_size     = number 
      min_size     = number      
    })
  }))

  default = {
    "general" = {
       instance_types   = ["t3.medium"]  # Fix: Change list to a string
       capacity_type   = "ON_DEMAND"
       scaling_config = {
         desired_size = 2
         max_size     = 4
         min_size     = 1
       }     
    }
  }
}

