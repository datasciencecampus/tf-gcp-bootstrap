# Project Guidelines

## Purpose

This repository hosts a standalone Terraform module for setting up CI access to Google Cloud in a secure-by-design way.

Changes should keep the module small, auditable, and safe for reuse across teams. Assume the repository may be public and fit for use by UK Civil Service organisations.

## Architecture

- The Terraform module lives in the repository root.
- Keep the module focused on CI setup concerns. Do not expand it into a general platform module.
- Prefer explicit IAM bindings and narrowly scoped inputs over broad abstractions.
- Treat default permissions as a security decision. Keep defaults minimal and explain why they are needed.
- If a change affects trust boundaries, default roles, impersonation, provider configuration, or release process, record the decision in `docs/adr/`.

## Security

- Design for least privilege. Avoid adding broad project-level roles unless there is a clear operational need.
- Do not commit secrets, private keys, backend credentials, real project IDs, real service account emails, or environment-specific values.
- Use placeholder values in documentation and examples.
- Prefer pinned versions for GitHub Actions, tooling, and Terraform-related dependencies.
- Keep security tooling working: pre-commit, `tflint`, `trivy`, `checkov`, and `detect-secrets` should remain part of the normal development flow unless there is a strong reason to change them.
- Document the security rationale for any new permission, role, or trust relationship.

## UK Civil Service Suitability

- Optimise for public-sector use: secure defaults, clear audit trails, predictable behaviour, and minimal operational surprise.
- Keep documentation clear enough for teams working under change control and assurance processes.
- Avoid assumptions that depend on undocumented organisation-specific infrastructure.
- Prefer transparent, reviewable configuration over cleverness.
- When introducing behaviour that may affect governance, assurance, or compliance review, add or update an ADR in `docs/adr/`.

## Terraform Conventions

- Keep variable names explicit and descriptive.
- Prefer simple resource composition over dynamic patterns unless they materially reduce risk or duplication.
- Add descriptions for all input variables.
- Keep outputs intentional. Do not add outputs that expose unnecessary identifiers or encourage unsafe coupling.
- Update `README.md` whenever inputs, defaults, resources, or usage expectations change.
- Preserve compatibility where practical. If a breaking change is necessary, call it out clearly in the documentation.

## Tests And Validation

For Terraform changes, agents should run the narrowest useful validation first, then widen only if needed.

- `pre-commit validate-config` for pre-commit changes.
- `pre-commit run terraform-docs-go --all-files` when module docs or README usage change.
- `terraform fmt -check -recursive .`
- `terraform init -backend=false`
- `terraform validate`
- `tflint --config ./configs/.tflint.hcl`
- `pre-commit run --all-files` before considering substantial Terraform or workflow changes complete, when the environment allows it.

If validation cannot be run, state that clearly and explain why.

## Documentation And ADRs

- Keep `README.md` focused on what the module does, why it exists, required inputs, defaults, and a minimal usage example.
- Keep terraform-docs output between the generated markers in `README.md`.
- Log key architectural and security decisions in `docs/adr/` using concise ADRs with context, decision, and consequences.
- When changing default permissions or trust relationships, update both the README and an ADR.

## Examples

- Prefer adding or updating minimal examples when they improve usability, especially after interface changes.
- Examples should be safe to publish, use placeholder identifiers, and demonstrate least-privilege usage first.
- Good example candidates include:
  - a minimal CI setup using only the default impersonation roles
  - a setup with additional project roles for a realistic Terraform workload
  - a usage example showing how to consume the module from another repository

## Workflow Expectations

- Keep GitHub workflows minimal, pinned, and root-module aware.
- Do not reintroduce assumptions that Terraform lives in old subdirectories.
- Prefer changes that improve reproducibility and reviewability over convenience-only automation.

## Change Quality

- Make the smallest change that solves the problem at the root cause.
- Avoid speculative features.
- Call out tradeoffs when security, usability, and backwards compatibility are in tension.
- If you introduce a new pattern, leave the repository easier to understand than before.
