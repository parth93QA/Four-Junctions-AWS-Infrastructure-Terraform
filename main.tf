module "ionginx-vpc" {
  source = "./modules/vpc"
}

module "ec2-auto-scaling-group" {
  source = "./modules/ec2_autoscaling_group"
  vpc_subnet_ids = module.ionginx-vpc.vpc_private_subnets
  vpc_id = module.ionginx-vpc.vpc_id
}

module "route53-nat-record" {
  source = "./modules/route53"
  nat_public_ip = module.ionginx-vpc.nat_public_ip
}