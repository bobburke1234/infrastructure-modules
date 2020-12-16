
terraform {
  backend "s3" {}
}

provider "kubernetes" {
  load_config_file       = "false"
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

#normalize inputs
locals {
  vpc_id = var.vpc_id
  vpc_pr_cidrs = var.vpc_private_subnet_cidr_blocks

  subnet_ids = [
    for subnet in data.aws_subnet.subnets:
      subnet.id
  ]
}

# Access the subnet ids
data "aws_subnet" "subnets" {
  count = length(local.vpc_pr_cidrs)
  cidr_block = local.vpc_pr_cidrs[count.index]
}

# Access the security groups to be used
data "aws_security_group" "worker_group_mgmt_one" {
  vpc_id = local.vpc_id

  filter {
    name = "group-name"
    values = ["worker_group_mgmt_one*"]
  }
}

data "aws_security_group" "worker_group_mgmt_two" {
  vpc_id = local.vpc_id

  filter {
    name = "group-name"
    values = ["worker_group_mgmt_two*"]
  }
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.eks_cluster_name
  cluster_version = "1.17"
  subnets         = local.subnet_ids

  tags = var.eks_cluster.tags

  vpc_id = local.vpc_id

  worker_groups = [
    {
      name                          = var.eks_cluster.worker_groups[0].name
      instance_type                 = var.eks_cluster.worker_groups[0].instance_type
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = var.eks_cluster.worker_groups[0].asg_desired_capacity
      additional_security_group_ids = [data.aws_security_group.worker_group_mgmt_one.id]
    },
    {
      name                          = var.eks_cluster.worker_groups[1].name
      instance_type                 = var.eks_cluster.worker_groups[1].instance_type
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = var.eks_cluster.worker_groups[1].asg_desired_capacity
      additional_security_group_ids = [data.aws_security_group.worker_group_mgmt_two.id]
    },
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
