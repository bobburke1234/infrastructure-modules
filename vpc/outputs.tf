
output "region" {
  description = "AWS region"
  value       = var.region
}

output "vpc" {
  description = "VPC"
  value = module.vpc
}
