module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name               = "customer-service-nlb"
  load_balancer_type = "network"
  vpc_id = module.service_provider_vpc.vpc_id
  subnets = module.service_provider_vpc.private_subnets

  target_group_tags = {
    Environment = "dev"
  }

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "TCP"
      target_group_index = 0
    }
  ]

  target_groups = [
    {
      name_prefix      = "sp-"
      backend_protocol = "TCP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
       webapp_target = {
         target_id = module.service_provider_app.id
         port = 80
       }
      }
      health_check = {
        enabled             = true
        interval            = 10
        path                = "/"
        port                = "80"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
      }
      tags = {
        Environment = "dev"
      }
    }
  ]

}
