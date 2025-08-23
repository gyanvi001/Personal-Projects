variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-0cfde0ea8edd312d4"
}

variable "instance_type" {
  description = "The instance type to use"
  type        = string
  default     = "t2.large"
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = "Terra-Automate2"
}