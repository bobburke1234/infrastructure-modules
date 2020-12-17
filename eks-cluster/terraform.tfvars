region = "us-east-1"
#EKS Cluster is restricted to two work
eks_cluster = ({
    cluster_name = "test"
    subnets = ["10.0.0.0./8"]
    tags = {}
    worker_groups = [({
             name = "worker_group_1"
             instance_type = "t2.small"
             asg_desired_capacity = 2
        }),
        ({
            name = "workder_group_2"
            instance_type = "t2.medium"
            asg_desired_capacity = 1 
        })
        ]
})
