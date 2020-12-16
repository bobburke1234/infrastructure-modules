
output "region" {
  description = "AWS region"
  value       = var.region
}

output "vpc" {
  description = "The entire VPC definition."
  value = module.vpc
}
output "eks_cluster_name" {
  value = local.eks_cluster_name
}



