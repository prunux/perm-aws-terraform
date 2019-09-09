# RDS
output "rds_database_name" {
  description = "The Database Name of the RDS"
  value       = module.rds_cluster_aurora_postgresql_serverless.database_name
}

output "rds_master_username" {
  description = "Username for the master DB user"
  value       = module.rds_cluster_aurora_postgresql_serverless.master_username
}

output "rds_cluster_identifier" {
  description = "Cluster Identifier"
  value       = module.rds_cluster_aurora_postgresql_serverless.cluster_identifier
}

output "rds_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = module.rds_cluster_aurora_postgresql_serverless.arn
}

output "rds_endpoint" {
  description = "The DNS address of the RDS instance"
  value       = module.rds_cluster_aurora_postgresql_serverless.endpoint
}

