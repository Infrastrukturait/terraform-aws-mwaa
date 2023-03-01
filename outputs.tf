output "arn" {
  value       = aws_mwaa_environment.this.arn
  description = "The arn of the created MWAA environment."
}

output "webserver_url" {
  value       = aws_mwaa_environment.this.webserver_url
  description = "The webserver URL of the MWAA Environment."
}
