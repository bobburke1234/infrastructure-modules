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
        vpc = ({
          id = "fake-id"
          private_subnet_ids = "fake-subnet-ids"
        })
        eks_cluster_name = "fake_eks_cluster_name"
    }
}

dependency "sgrps" {
    config_path = "../security-groups"

    mock_outputs = {
      sgrps = ({
        "worker_groups" = [
          ({id="fake-id"}),
          ({id="fake-id"})
        ]
      })
    }
  }

inputs = {
  vpc  = dependency.vpc.outputs.vpc
  sgrps  = dependency.sgrps.outputs.sgrps
  eks_cluster_name = dependency.vpc.outputs.eks_cluster_name
}
