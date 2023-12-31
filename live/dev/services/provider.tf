terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket         = "mb-internship-terraform-tfstate"
    key            = "dev/services/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "mb-terraform-state-locks"
  }
}

# Configure the AWS Provider
provider "aws" {
  /* shared_config_files      = ["/Users/marianbodnar/.aws/config"]
  shared_credentials_files = ["/Users/marianbodnar/.aws/credentials"] */
}