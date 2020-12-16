include {
  path = find_in_parent_folders()
}
dependencies {
  paths = ["../vpc"]
}
dependency "vpc" {
  config_path = "../vpc"
}
inputs = {
  vpc_id = dependency.vpc.outputs.vpc.vpc_id
  vpc_cidr_block = dependency.vpc.outputs.vpc.vpc_cidr_block
  region = dependency.vpc.outputs.region
}