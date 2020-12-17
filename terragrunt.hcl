

locals {
  environment = "dev"
  aws_region  = "us-west-2"
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "${local.aws_region}-terraform-state-bi-123612"
    region         = "${local.aws_region}"
    dynamodb_table = "training-terraform"
    encrypt        = true
    
    


    key = "${local.environment}/${local.aws_region}/${path_relative_to_include()}"

    s3_bucket_tags = {
      owner       = "training"
      name        = "traing-state"
      environment = "${local.environment}"
    }

    dynamodb_table_tags = {
      owner       = "training"
      name        = "training-state"
      environment = "${local.environment}"
    }
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
provider "aws" {
  region              = "us-west-2"
}
EOF
}
