output "sgrps" {
  value = ({
    "worker_groups" = [
      aws_security_group.worker_group_mgmt_one,
      aws_security_group.worker_group_mgmt_two
    ]
  })
}