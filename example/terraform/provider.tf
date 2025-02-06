provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "Deploy Lambda with Container Image"
      Owners      = "Noor"
      Provisioner = "Terraform"
    }
  }
}