resource "google_service_account_iam_member" "impersonation" {
  for_each = toset(var.impersonation_roles)

  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.target_service_account_email}"
  role               = each.value
  member             = "serviceAccount:${var.host_service_account_email}"
}

resource "google_project_iam_member" "target_service_account_additional_roles" {

  for_each = toset(concat(
    var.target_service_account_additional_roles,
    [
      "roles/serviceusage.serviceUsageConsumer",
      "roles/iam.viewer"
    ]
  ))

  role    = each.value
  member  = "serviceAccount:${var.target_service_account_email}"
  project = var.project_id
}
