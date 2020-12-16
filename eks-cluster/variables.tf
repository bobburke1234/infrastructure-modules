variable "region" {}
variable "vpc_id" {}
variable "vpc_private_subnets_cidr_blocks" {}



#Define an EKS object
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