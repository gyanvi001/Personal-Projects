provider "aws" {
  region  = "us-west-2"
}

#Get the default vpc details
data "aws_vpc" "default" {
  default  = true
}

#Get default subnets from the vpc
data "aws_subnet" "default" {
    filter {
        # only return subnets that belong to a specific VPC ID
        name    = "vpc_id"
        values  = [data.aws_vpc.default.id]
    }
}


#Create a security group for the web server
resource "aws_security_group" "Web-Sg" {
    name         = "web-sg"
    description  = "Allow SSH, HTTP , HTTPS"
    vpc_id       = data.aws_vpc.default.id

    ingress {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
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
        description = "HTTPS"
        from_port   = 443
        to_port     = 443
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


resource "aws_instance" "WebServer" {
    ami                = "ami-05f991c49d264708f"
    instance_type      = "t3.xlarge"
    subnet_id          = data.aws_subnet.default.id
    security_groups    = [aws_security_group.Web-Sg.name]
   
    root_block_device {
    volume_size = 20
    volume_type = "gp2"
    }

  tags = {
    Name = "terraform-ec2"
  }

}