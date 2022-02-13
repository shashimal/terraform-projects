resource "aws_codecommit_repository" "codecommit_repository" {
  repository_name = var.codecommit_repository_name
}