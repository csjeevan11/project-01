module "vpc" {
source = "./modules/vpc"

vpc_cidr = "10.0.0.0/16"
public_subnet_1 ="10.0.1.0/24"
public_subnet_2 ="10.0.2.0/24"

private_subnet_1 ="10.0.3.0/24"
private_subnet_1 ="10.0.4.0/24"

}

module "eks" {
source = "./modules/eks"
cluster_name ="jeevan-eks"
subnet_ids = module.vpc.public_subnet_ids
vpc_id = module.vpc.vpc_id
}