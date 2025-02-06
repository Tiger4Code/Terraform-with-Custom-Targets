module "s3_one_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.2.2"

  bucket = var.s3_first_bucket_name

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"

  expected_bucket_owner = local.account_id


  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

}

module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 2.3.1"

  repository_name = "noor-test-repo-name"

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        action = {
          type = "expire"
        }
        description  = "lifecycle"
        rulePriority = 1
        selection = {
          countNumber = 5
          countType   = "imageCountMoreThan"
          tagStatus   = "untagged"
        }
      }
    ]
  })

}

resource "aws_cloudwatch_log_group" "example" {
  name              = "noor-example-log-group-resource"
  retention_in_days = 1 # Logs will be retained for 7 days
}