variable "bucket_name" {
  description = "Name of the s3 bucket"
  type = string
}

variable "tags" {
  description = "S3 Bucket tags"
  type = map(string)
  default = {}
}