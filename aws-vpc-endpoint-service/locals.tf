locals {
  ingress_rules = {
    http = {
      port = 80
      source = "0.0.0.0/0"
    }
    ssh = {
      port = 22
      source = "0.0.0.0/0"
    }
  }
}
