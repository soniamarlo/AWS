output "alb_dns" {
  description = "The DNS of the ALB"
  value       = aws_lb.nginx_alb-sonia.dns_name
}


output "target_group_arn" {
  description = "The Target Group ARN for the ALB"
  value       = aws_lb_target_group.nginx_tg-sonia.arn
}
output "subnets" {
  description = "The subnets used by the ALB"
  value       = data.aws_subnets.default.ids
}