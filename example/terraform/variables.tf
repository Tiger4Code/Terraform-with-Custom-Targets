# variables.tf

variable "environment" {
  description = "Environment Variable"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "us-east-1" # Choose the region for your S3 bucket
}

variable "s3_first_bucket_name" {
  type        = string
  default     = null
}
variable "s3_second_bucket_name" {
  type        = string
  default     = null
}
variable "s3_third_bucket_name" {
  type        = string
  default     = null
}

