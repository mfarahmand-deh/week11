# Terraform settings
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "REPLACE_ME"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}

# AWS provider
provider "aws" {
  region = "us-west-2"
}

# Random name generator for security group
resource "random_pet" "sg" {}

# Security group only
resource "aws_security_group" "web-sg" {
  name        = "${random_pet.sg.id}-sg"
  description = "Staging web server security group"

  # Ingress: only allow your specific IP
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["203.0.113.10/32"] # replace with your IP
  }

  # Egress: allow all (or restrict as needed)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # you can restrict if needed
  }
}
