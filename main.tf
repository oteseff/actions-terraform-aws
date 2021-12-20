# Require TF version to be same as or greater than 0.12.13
terraform {
  required_version = ">=0.12.13"
  backend "s3" {
    bucket         = "actions-terraform-aws-tfstate"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "aws-locks"
    encrypt        = true
  }
}

# Download any stable version in AWS provider of 2.36.0 or higher in 2.36 train
provider "aws" {
  region  = "us-west-2"
  version = "~> 2.36.0"
}

/*

# Call the seed_module to build our ADO seed info
module "bootstrap" {
  source                      = "./modules/bootstrap"
  name_of_s3_bucket           = "actions-terraform-aws-tfstate"
  dynamo_db_table_name        = "aws-locks"
  iam_user_name               = "GitHubActionsIamUser"
  ado_iam_role_name           = "GitHubActionsIamRole"
  aws_iam_policy_permits_name = "GitHubActionsIamPolicyPermits"
  aws_iam_policy_assume_name  = "GitHubActionsIamPolicyAssume"
}

# Build the VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "10.1.0.0/16"
  instance_tenancy     = "default"

  tags = {
    Name      = "VPC"
    Terraform = "true"
  }
}

# Build route table 1
resource "aws_route_table" "route_table1" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "RouteTable1"
    Terraform = "true"
  }
}

# Build route table 2
resource "aws_route_table" "route_table2" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "RouteTable2"
    Terraform = "true"
  }
}

*/

resource "aws_instance" "app_server" {
  #ami           = "ami-08d70e59c07c61a3a" #ubuntu
  ami           = "ami-00f7e5c52c0f43726" #amazon linux 2
  instance_type = "t2.micro"
  key_name      = "aws-default"
  user_data     = <<-EOF
                #!/bin/bash
                sudo su
                yum -y install httpd
                echo "<p> My Instance! </p>" >> /var/www/html/index.html
                sudo systemctl enable httpd
                sudo systemctl start httpd
                EOF

  tags = {
    Name = var.instance_name
  }
}
