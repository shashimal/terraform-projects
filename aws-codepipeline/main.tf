provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "artifact_bucket" {
  bucket = "du-codepipeline-artifact"
}


module "codecommit" {
  source = "./modules/source"
  codecommit_repository_name = "lambda-test-repository"
}

module "codebuild" {
  source = "./modules/build"
  artifact_bucket_arn = aws_s3_bucket.artifact_bucket.arn
}

module "codepipeline" {
  source = "./modules/codepipeline"
  codecommit_repository_name = module.codecommit.codecommit_repository_name
  branch_name                = "master"
  codebuild_project          = module.codebuild.codebuild_project_name
  artifact_bucket = "du-codepipeline-artifact"

  depends_on = [aws_s3_bucket.artifact_bucket]
}