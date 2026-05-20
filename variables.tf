variable "project_id" {
  description = "Google Cloud project ID for the target environment."
  type        = string
}

variable "host_service_account_email" {
  description = "Email of the host CI service account allowed to impersonate the target Terraform service account."
  type        = string
}

variable "target_service_account_email" {
  description = "Email of the pre-provisioned target Terraform service account in this project."
  type        = string
}

variable "impersonation_roles" {
  description = "IAM roles granted on the target service account to the host CI service account."
  type        = list(string)
  default = [
    "roles/iam.serviceAccountTokenCreator",
  ]
}

variable "target_service_account_additional_roles" {
  description = "Additional IAM roles to assign to the target Terraform service account."
  type        = list(string)
  default     = []
}
