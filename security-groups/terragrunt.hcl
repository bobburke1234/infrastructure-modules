include {
  path = find_in_parent_folders()
}
dependencies {
  paths = ["../vpc"]
}
dependency "vpc" {
  config_path = "../vpc"

  mock_outputs_allowed_terraform_commands = ["validate","plan"]
  
  mock_outputs = {
    vpc_id = "fake_id"
    vpc_cidr_block  = "fake_cidr_block"
  }
}
inputs = {
  vpc_id = dependency.vpc.outputs.id
  vpc_cidr_block = dependency.vpc.outputs.cidr_block
}