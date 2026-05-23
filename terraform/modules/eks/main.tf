module "eks" {

source = "terraform-aws-modules/eks/aws"
version = "~> 20.0"

cluster_name = var.cluster_name
cluster_version = "1.33"

subnet_ids = var.subnet_ids
enable_cluster_creator_admin_permissions = true
vpc_id = var.vpc_id
eks_managed_node_groups = {
eks_nodes ={
    desired_size = 2
    max_size = 3
    min_size = 1

    instance_types = ["t3.micro"]

    capacity_type = "ON_DEMAND"
}
}
tags = {

Environment = "dev"

Terraform = "true"

}
}
