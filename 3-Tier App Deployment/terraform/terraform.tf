

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the cloud provider
provider "aws" {
  region = "us-east-1"
}