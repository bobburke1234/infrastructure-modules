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
    vpc = ({
      id = "fake-id"
    })
  }
}
inputs = {
  vpc  = dependency.vpc.outputs.vpc
}