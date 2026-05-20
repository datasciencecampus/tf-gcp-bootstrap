# Private/Internal Repository Reasoning Record (PIRR)
<!-- This template provides a structured format for documenting the rationale behind the requirement for a private or internal repository, ensuring that the decision-making process is transparent and well-documented. -->

## Repository Name

tf-gcp-bootstrap

## Date Reviewed

2026-05-20

## Reason for Private/Internal Repository

Private or internal hosting is not currently required for the repository's present contents.

This repository contains a small reusable Terraform module, placeholder examples, and general documentation describing a CI-to-Google-Cloud service-account impersonation pattern. The current tracked files do not contain live credentials, real project identifiers, backend configuration, or environment-specific operational data.

The strongest arguments for keeping the repository private would be defensive rather than mandatory:

- the repository documents a reusable CI-to-GCP trust pattern that could help an attacker understand how downstream consumers are likely to structure impersonation
- the repository discloses default impersonation roles and baseline permissions that may assist reconnaissance after compromise of a consuming CI identity
- the repository exposes limited ownership and process metadata that can improve social-engineering quality

These factors create residual risk, but they do not currently justify a private-by-default classification on their own.

Recommendation: keep the repository public, subject to the compensating controls and review triggers listed below.

## Sensitivity of Information

Current sensitivity is low to moderate.

The repository contains:

- Terraform code that grants explicit service account impersonation and project IAM roles
- documentation of the intended trust model and default permissions
- placeholder service account names and project identifiers
- CI workflow and code ownership metadata

The repository does not currently contain:

- secrets, private keys, access tokens, or backend credentials
- real service account emails or real project IDs in tracked source files
- environment-specific deployment state or production incident detail beyond a brief note that one scanner is disabled

The main sensitivity concern is architectural disclosure rather than secret disclosure.

## Access Control Needs

No strict access control requirement is currently evidenced by the repository contents.

If the repository later begins to include any of the following, access restrictions should be revisited immediately:

- real project identifiers, service account emails, workload identity pool identifiers, or organisation-specific trust bindings
- environment-specific examples, plans, or state fragments
- unpublished vulnerability details, incident-response notes, or compensating-control gaps that materially aid exploitation
- internal-only operational runbooks or governance artefacts that expose review or approval weaknesses

## Collaboration Requirements

Public collaboration is consistent with the repository's current purpose as a reusable module intended for auditable review.

Public hosting supports:

- transparent review of IAM defaults and trust assumptions
- reuse across teams without duplicating documentation privately
- external scrutiny of least-privilege claims and workflow hygiene

Private hosting would only be preferable if collaboration shifted toward environment-specific implementation detail rather than a generic publishable module.

## Security and Compliance Considerations

Security and compliance considerations support a conditional-public position.

Compensating controls required for public hosting:

- do not commit real environment identifiers, backend configuration, secrets, or service account emails
- keep examples and README values placeholder-only
- restore or replace currently disabled security scanning so that public distribution is backed by a complete baseline of automated checks
- review outputs and documentation regularly to ensure they do not encourage downstream disclosure of sensitive identifiers
- continue pinning GitHub Actions and security tooling versions
- treat any change to default permissions, impersonation roles, or trust relationships as an architectural review point

Review triggers for moving to private/internal:

- the module evolves from a generic pattern into a repository tied to a named organisation, tenant, or production environment
- consumers request inclusion of internal trust topology, federation configuration, or real identities for convenience
- the repository begins to accumulate incident-specific context or exploitation-relevant operational exceptions

From a UK public-sector suitability perspective, the repository is publishable if it remains generic, auditable, and free of environment-specific data.

## Additional Notes

This recommendation is based on the repository contents reviewed on 2026-05-20.

Residual public-exposure risks to monitor:

- attacker reconnaissance of the documented CI impersonation model
- downstream users copying the pattern with real identities and then exposing those identities in logs, plans, issues, or examples
- reputational impact of publishing workflow gaps such as disabled scanners without a clear remediation path

If desired, a follow-up change should remove or reword public references to the disabled scanner and add a short statement in the README or governance docs clarifying that examples must remain placeholder-only.
