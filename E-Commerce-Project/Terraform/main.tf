provider "aws" {
    region = "us-west-2"
}

resource "aws_s3_bucket" "ecommerce_bucket" {
    bucket = "demo-ecommerce-bucket"


    lifecycle {
        prevent_destroy = false
    }   

    force_destroy = true
}



resource "aws_dynamodb_table" "basic-dynamodb_table" {
    name           = "demo-ecommercetable"
    billing_mode   = "PAY_PER_REQUEST"
    hash_key       = "LockID"
       

    attribute {
        name = "LockID"
        type = "S"
    }
}