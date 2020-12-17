
output "vpc" {
  description = "The VPC object"
  value = ({
    #Convenience mapping
    id = module.vpc.vpc_id
    cidr_block = module.vpc.vpc_cidr_block
    private_subnets_cidr_blocks = module.vpc.private_subnets_cidr_blocks
    private_subnet_ids = module.vpc.private_subnets
    #Base object
    this = module.vpc
  })
}
output "eks_cluster_name" {
  value = local.eks_cluster_name
}
 


