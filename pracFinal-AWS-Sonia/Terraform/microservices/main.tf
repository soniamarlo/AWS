module "alb" {
  source             = "../alb"
  alb_name           = "nginx-alb"
  tg_name            = "nginx-tg"
  vpc_id             = var.vpc_id
  public_subnets     = var.public_subnets
  security_group_id  = var.security_group_id
}

module "ecs" {
  source             = "../ecs"
  ecs_cluster_name   = "nginx-cluster"
  execution_role_arn = var.execution_role_arn
  desired_count      = var.desired_count
  public_subnets     = var.public_subnets
  security_group_id  = var.security_group_id
  target_group_arn   = module.alb.alb_dns
}
