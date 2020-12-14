variable "region" {
  type = string
  default     = "us-east-2"
  description = "Default VPC AWS region"
}

variable "vpc" {
  type = object ({
    name = string
    cidr = string
    eks_cluster_name = string
    private_subnets = list(string)
    public_subnets = list(string)
})
}