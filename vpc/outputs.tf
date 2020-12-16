
output "id" {
  description = "The vpc cidr block"
  value = module.vpc.vpc_id
}

output "cidr_block" {
  description = "The vpc cidr block."
  value = module.vpc.vpc_cidr_block
}

output "private_subnets_cidr_blocks" {
  description = "The vpc private subnet cidr blocks"
  value = module.vpc.private_subnets_cidr_blocks
}

output "private_subnets_ids" {
  description = "The vpc private subnet ids"
  value = module.vpc.private_subnets
}

output "eks_cluster_name" {
  value = local.eks_cluster_name
}



