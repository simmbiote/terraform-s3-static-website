variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "eu-west-1"
}

variable "project_name" {
  type        = string
  description = "Provide the name of your project this relates to. (kebab-case)"
}

variable "team" {
  type        = string
  description = "Which team are you with?"
}

variable "bucket_name" {
  type        = string
  description = "The name of your S3 bucket. (kebab-case). For a static website, use the fully qualified domain name as the bucket name."
}
