output "target_service_account_email" {
  description = "Email address of the target Terraform service account."
  value       = var.target_service_account_email
}

output "host_service_account_email" {
  description = "Email address of the host CI service account allowed to impersonate the target Terraform service account."
  value       = var.host_service_account_email
}
