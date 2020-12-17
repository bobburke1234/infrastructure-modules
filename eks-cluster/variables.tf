
#Input passed through modules via terragrunt
variable "vpc" {}
variable "sgrps" {}
variable "region" {}

#Input passed through via tfvars.
variable "eks_cluster_name" {}

variable "eks_cluster" {
  type = object ({
    cluster_name = string
    subnets = list(string)
    tags = map(string)
    worker_groups = list(object ({ 
      name                          = string
      instance_type                 = string
      asg_desired_capacity          = number
    }))
  })
}
