variable "vpc" {
  type = object ({
    name = string
    cidr = string
    eks_cluster_name = string
    private_subnets = list(string)
    public_subnets = list(string)
})
}