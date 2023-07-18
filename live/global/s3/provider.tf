terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  shared_config_files      = ["/Users/marianbodnar/.aws/config"]
  shared_credentials_files = ["/Users/marianbodnar/.aws/credentials"]
}