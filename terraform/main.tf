provider "aws" {
  region = var.aws_region
}

# Create a bucket

resource "aws_s3_bucket" "s3-bucket" {

  bucket = var.bucket_name
  acl    = "private" # or can be "public-read" or "private"
  tags = {
    Name        = var.bucket_name
    Project     = var.project_name
    Team        = var.team
    Environment = "Sandbox"
  }

  lifecycle_rule {
    id      = "log"
    enabled = true
    # prefix = "log/"
    tags = {
      rule      = "log"
      autoclean = "true"
    }
    transition {
      days          = 30
      storage_class = "STANDARD_IA" # or "ONEZONE_IA"
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
    expiration {
      days = 90
    }
  }

  # Uncomment this to enable static website hosting
  #   Suitable for small scale static sites only.
  # For larger production sites, use a CloudFront Distribution as well.

  #   website {
  #     index_document = "index.html"
  #     error_document = "error.html"
  #   }


}

# Uncomment this to make the *entire* bucket public readable. 
# Enable public access
# If Block Public Access is configured on your account
# this will throw permssion errors.
# resource "aws_s3_bucket_policy" "bucket-policy" {
#   bucket = aws_s3_bucket.s3-bucket.id
#   policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [
#       {
#         "Sid" : "AddPerm",
#         "Effect" : "Allow",
#         "Principal" : "*",
#         "Action" : ["s3:GetObject"],
#         "Resource" : ["arn:aws:s3:::${var.bucket_name}/*"]
#       }
#     ]
#   })
# }

# Upload files to S3
resource "aws_s3_bucket_object" "static-files" {
  for_each = fileset("../html/", "*")
  bucket   = aws_s3_bucket.s3-bucket.id
  key      = each.value
  source   = "../html/${each.value}"
  etag     = filemd5("../html/${each.value}")

  # Uncomment this to make the file public readable (not the entire bucket).
  # If Block Public Access is configured on your account
  # this will throw permssion errors.
  # Make the object accessible via the browser.
  #   acl      = "public-read"
}

output "S3BucketBucketwebsite_domain" {
  value = aws_s3_bucket.s3-bucket.website_domain
}

output "S3BucketBucketDomain" {
  value = aws_s3_bucket.s3-bucket.bucket_domain_name
}

output "S3BucketBucketPrefix" {
  value = aws_s3_bucket.s3-bucket.bucket_prefix
}
