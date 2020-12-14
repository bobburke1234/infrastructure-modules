variable "region" {
    type = string
}

#EKS Cluster depends on VPC and Security Groups being setup
variable "vpc" {}


#Define an EKS object
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