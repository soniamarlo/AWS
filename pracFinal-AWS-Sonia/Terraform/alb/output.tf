output "alb_dns" {
  description = "The DNS of the ALB"
  value       = aws_lb.nginx_alb-sonia.dns_name
}

output "security_group_id" {
  description = "The Security Group ID for the ALB"
  value       = data.aws_security_group.default.id
}


output "target_group_arn" {
  description = "The Target Group ARN for the ALB"
  value       = aws_lb_target_group.nginx_tg-sonia.arn
}
