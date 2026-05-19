# terraform-ci-setup

Terraform module for wiring GitHub Actions or other CI automation to a pre-provisioned Terraform service account in Google Cloud.

It is intended to be a small, reusable root module with secure-by-design defaults that are suitable for public-sector delivery and review.

The module does two things:

- Grants a host CI service account permission to impersonate the target Terraform service account.
- Assigns baseline and optional project-level IAM roles to the target Terraform service account in the target project.

## What this module manages

For the target Google Cloud project, this module creates:

- `google_service_account_iam_member` bindings for each impersonation role in `impersonation_roles`.
- `google_project_iam_member` bindings for the target Terraform service account.

The target service account always receives these baseline project roles:

- `roles/serviceusage.serviceUsageConsumer`
- `roles/iam.viewer`

You can add more project roles with `target_service_account_additional_roles`.

A minimal publishable example is available in `examples/minimal`.

## Usage

```hcl
module "terraform_ci_setup" {
   source = "github.com/datasciencecampus/terraform-ci-setup"

   project_id                 = "my-gcp-project"
   host_service_account_email = "github-actions@host-project.iam.gserviceaccount.com"
   target_service_account_email = "terraform@my-gcp-project.iam.gserviceaccount.com"

   target_service_account_additional_roles = [
      "roles/storage.admin",
      "roles/compute.viewer",
   ]
}
```

Run Terraform from the repository root:

```bash
terraform init
terraform plan
terraform apply
```

## Inputs and behavior

- `project_id` identifies the Google Cloud project where IAM bindings are applied.
- `host_service_account_email` is the CI identity that needs to impersonate the Terraform service account.
- `target_service_account_email` is the pre-existing service account used for Terraform operations in the target project.
- `impersonation_roles` defaults to `roles/iam.serviceAccountTokenCreator` and `roles/iam.serviceAccountUser`.
- `target_service_account_additional_roles` lets you add project-level permissions beyond the built-in baseline roles.

This module assumes the target service account already exists before Terraform is applied.

The host CI service account email is required because the module always creates explicit impersonation bindings for the target Terraform service account.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.0.0, < 8.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | 7.32.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [google_project_iam_member.target_service_account_additional_roles](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account_iam_member.impersonation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_host_service_account_email"></a> [host\_service\_account\_email](#input\_host\_service\_account\_email) | Email of the host CI service account allowed to impersonate the target Terraform service account. | `string` | n/a | yes |
| <a name="input_impersonation_roles"></a> [impersonation\_roles](#input\_impersonation\_roles) | IAM roles granted on the target service account to the host CI service account. | `list(string)` | <pre>[<br/>  "roles/iam.serviceAccountTokenCreator",<br/>  "roles/iam.serviceAccountUser"<br/>]</pre> | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Google Cloud project ID for the target environment. | `string` | n/a | yes |
| <a name="input_target_service_account_additional_roles"></a> [target\_service\_account\_additional\_roles](#input\_target\_service\_account\_additional\_roles) | Additional IAM roles to assign to the target Terraform service account. | `list(string)` | `[]` | no |
| <a name="input_target_service_account_email"></a> [target\_service\_account\_email](#input\_target\_service\_account\_email) | Email of the pre-provisioned target Terraform service account in this project. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_host_service_account_email"></a> [host\_service\_account\_email](#output\_host\_service\_account\_email) | Email address of the host CI service account allowed to impersonate the target Terraform service account. |
| <a name="output_target_service_account_email"></a> [target\_service\_account\_email](#output\_target\_service\_account\_email) | Email address of the target Terraform service account. |
<!-- END_TF_DOCS -->
