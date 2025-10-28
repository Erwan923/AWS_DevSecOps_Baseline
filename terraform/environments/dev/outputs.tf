output "vpc_id" { value = module.vpc.vpc_id }
output "public_subnets" { value = module.vpc.public_subnet_ids }
output "private_subnets" { value = module.vpc.private_subnet_ids }

output "ecs_cluster_name" { value = module.ecs.cluster_name }
output "ecs_service_name" { value = module.ecs.service_name }
output "ecs_log_group" { value = module.ecs.log_group_name }
