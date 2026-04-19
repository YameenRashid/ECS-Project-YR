output "certificate_arn" {
    description = "ARN of the ACM Cert"
    value = aws_acm_certificate_validation.val.certificate_arn
}