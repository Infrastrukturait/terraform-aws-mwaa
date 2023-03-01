output "airflow_arn" {
  value       = module.app_prod_airflow.arn
  description = "The arn of the created MWAA environment."
}

output "airflow_webserver_url" {
  value       = module.app_prod_airflow.webserver_url
  description = "The webserver URL of the MWAA Environment."
}
