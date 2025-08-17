provider "aws" {
  region = "us-west-2"
}

#Get the default vpc details
data "aws_vpc" "default" {
  default = true
}

#Get default subnets from the vpc
data "aws_subnet" "default" {
    filter {
        # only return subnets that belong to a specific VPC ID
        name = "vpc_id"
        values = [data.aws_vpc.default.id]
    }
}





resource "aws_instance" "WebServer" {
    type = "t3.xlarge"

}