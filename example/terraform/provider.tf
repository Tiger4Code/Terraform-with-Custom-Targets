provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "Selective tf execution"
      Owners      = "Noor"
      Provisioner = "Terraform"
    }
  }
}