
terraform {
  backend "s3" {}
}

provider "kubernetes" {
  load_config_file       = "false"
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

#normalize inputs from terragrunt inputs
locals {
  sgrps = jsondecode(var.sgrps)
  vpc = jsondecode(var.vpc)
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.eks_cluster_name
  cluster_version = "1.17"
  subnets         = local.vpc.private_subnet_ids

  tags = var.eks_cluster.tags

  vpc_id = local.vpc.id

  worker_groups = [
    {
      name                          = var.eks_cluster.worker_groups[0].name
      instance_type                 = var.eks_cluster.worker_groups[0].instance_type
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = var.eks_cluster.worker_groups[0].asg_desired_capacity
      additional_security_group_ids = [local.sgrps.worker_groups[0].id]
    },
    {
      name                          = var.eks_cluster.worker_groups[1].name
      instance_type                 = var.eks_cluster.worker_groups[1].instance_type
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = var.eks_cluster.worker_groups[1].asg_desired_capacity
      additional_security_group_ids = [local.sgrps.worker_groups[1].id]
    },
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
