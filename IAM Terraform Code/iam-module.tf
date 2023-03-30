provider "aws" {
  region = "us-east-1"
}

module "iam-resources" {
  source = "./path/to/iam-module"
  
  name   = "prod-ci"
  suffix = "-test"
}
