# variables.tf

variable "environment" {
  description = "Environment"
  type        = string
  default     = null
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = null
}

variable "s3_first_bucket_name" {
  type    = string
  default = null
}
variable "s3_second_bucket_name" {
  type    = string
  default = null
}
variable "s3_third_bucket_name" {
  type    = string
  default = null
}

