provider "aws" {
  region = "us-east-1"
}

module "static_website" {
  source = "./modules/static-website"
  bucket_name = var.s3-bucket-name
}