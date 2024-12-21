## Terraform 0.13 and later:

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5..80.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}  
