
vpc = ({
    name = "training-vpc"
    cidr = "10.0.0.0/16"
    eks_cluster_name = "training-vpc-1"
    public_subnets = ["10.0.1.0/24","10.0.2.0/24", "10.0.3.0/24"]
    private_subnets = ["10.0.4.0/24","10.0.5.0/24", "10.0.6.0/24"]
})

