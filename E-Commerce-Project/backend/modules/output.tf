output "cluster_endpoint" {   # ✅ Fixed Typo
    value = module.eks.cluster_endpoint
}

output "cluster_name" {
    value = module.eks.cluster_name
}

output "vpc_id" {
    value = module.vpc.vpc_id  # ✅ Correct
}