# ADR 0001: Default CI Impersonation Model

## Status

Accepted

## Context

This module exists to set up a CI identity so that Terraform can run against a target Google Cloud project using a pre-provisioned Terraform service account.

The main design questions for the initial release are:

- how the host CI identity should authenticate to the target Terraform identity
- which permissions should be granted by default
- how to keep the module suitable for reuse in public-sector environments with clear auditability and low operational surprise

## Decision

The module uses explicit service account impersonation.

The host CI service account is granted the default impersonation roles needed to act as the target Terraform service account:

- `roles/iam.serviceAccountTokenCreator`
- `roles/iam.serviceAccountUser`

The target Terraform service account is granted two baseline project roles by default:

- `roles/serviceusage.serviceUsageConsumer`
- `roles/iam.viewer`

Any additional project-level permissions must be supplied explicitly by the caller.

The host CI service account email is a required input because the impersonation bindings are core to the module's purpose.

## Consequences

This keeps the module aligned with least-privilege by making the default role set small and auditable.

Consumers still need to decide whether additional project roles are necessary for their Terraform workloads.

Changes to the default trust model or baseline permissions should be treated as architectural decisions and recorded in a follow-up ADR.
