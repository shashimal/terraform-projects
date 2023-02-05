variable "user_names" {
  description = "Create IAM users with these names"
  type = list(string)
  default = ["neo", "morpheus"]
}



resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name = var.user_names[count.index]
}

output "users" {
  value = aws_iam_user.example[*].arn
}