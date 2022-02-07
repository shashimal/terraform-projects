output "arn" {
  description = "ARN of the bucket"
  value       = aws_s3_bucket.static_website.arn
}

output "name" {
  description = "Name of the bucket"
  value       = aws_s3_bucket.static_website.id
}

output "domain" {
  description = "Name of the domain"
  value       = aws_s3_bucket.static_website.website_domain
}