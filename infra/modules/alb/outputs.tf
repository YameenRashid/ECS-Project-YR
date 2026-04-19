output "alb_dns_name" {
  description = "DNS name of ALB"
  value = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "Zone ID of ALB"
  value = aws_lb.main.zone_id
}

output "alb_sg_id" {
  description = "Security Group ID of ALB"
  value = aws_security_group.alb.id
}

output "tg_arn" {
  description = "Target Group Arn"
  value = aws_alb_target_group.app.arn
}