output "postgres_instance_connection_name" {
  description = "The connection name of the PostgreSQL instance."
  value       = google_sql_database_instance.postgres_instance.connection_name
}

output "postgres_instance_ip" {
  description = "The public IP address of the PostgreSQL instance."
  value       = google_sql_database_instance.postgres_instance.public_ip_address
}
