include {
  path = find_in_parent_folders()
}
dependencies {
  paths = ["../vpc" , "../security-groups"]
}
dependency "vpc" {
  config_path = "../vpc"
}

dependency "security-groups" {
    config_path = "../security-groups"
    skip_outputs = true
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc.vpc_id
  vpc_private_subnets_cidr_blocks = dependency.vpc.outputs.vpc.private_subnets_cidr_blocks
  region = dependency.vpc.outputs.region
  eks_cluster_name = dependency.vpc.outputs.eks_cluster_name
}
