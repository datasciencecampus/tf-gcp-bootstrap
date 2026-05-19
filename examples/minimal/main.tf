terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.0.0, < 8.0.0"
    }
  }
}

provider "google" {
  project = "my-gcp-project"
}

module "terraform_ci_setup" {
  source = "../.."

  project_id                   = "my-gcp-project"
  host_service_account_email   = "github-actions@host-project.iam.gserviceaccount.com"
  target_service_account_email = "terraform@my-gcp-project.iam.gserviceaccount.com"
}
