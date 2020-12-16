include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../vpc" , "../security-groups"]
}

dependency "vpc" {
  config_path = "../vpc"

   mock_outputs_allowed_terraform_commands = ["validate","plan"]

    mock_outputs = {
        vpc_id = "fake_vpc_id"
        vpc_private_subnet_ids = ["fake_vpc_subnet_ids"]
        eks_cluster_name = "fake_eks_cluster_name"
    }
}

dependency "security-groups" {
    config_path = "../security-groups"

    mock_outputs = {
        worker_group_1 = ({
          id = "fake_id"
        })
        worker_group_2 = ({
          id = "fake_id"
        })
    }
  }

inputs = {
  vpc_id = dependency.vpc.outputs.id
  vpc_private_subnet_ids = dependency.vpc.outputs.private_subnets_ids
  eks_cluster_name = dependency.vpc.outputs.eks_cluster_name
  sg_wg_1_id = dependency.security-groups.outputs.worker_group_1.id
  sg_wg_2_id = dependency.security-groups.outputs.worker_group_2.id
}
