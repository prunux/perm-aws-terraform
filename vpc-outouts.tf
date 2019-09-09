# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_private_subnets" {
  description = "The private subnet IDs of the VPC"
  value       = module.vpc.private_subnets
}

output "vpc_public_subnets" {
  description = "The public subnet IDs of the VPC"
  value       = module.vpc.public_subnets
}

output "ipv6_association_id" {
  description = "The IPv6 CIDR block"
  value       = module.vpc.vpc_ipv6_cidr_block
}

output "ipv6_cidr_block" {
  description = "The association ID for the IPv6 CIDR block"
  value       = module.vpc.vpc_ipv6_association_id
}