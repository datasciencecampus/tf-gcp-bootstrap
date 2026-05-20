# ADR 0002: Release Automation With Release Please

## Status

Accepted

## Context

This module needs a predictable release process for consumers who pin Git tags and for maintainers who need auditable release notes.

The release process should stay lightweight, work from the root module, and avoid bespoke scripting in GitHub Actions.

## Decision

The repository uses the pinned `googleapis/release-please-action` workflow on pushes to `main`.

Release Please maintains a release pull request from Conventional Commit history and creates the GitHub release and tag when that release PR is merged.

The repository tracks the current module version in `version.txt` and the generated release notes in `CHANGELOG.md`.

## Consequences

Maintainers need to use releasable Conventional Commit prefixes such as `fix:`, `feat:`, and `feat!:` when changes should appear in a release.

The repository must allow GitHub Actions to create pull requests for fully automated release PR creation.

This keeps release logic pinned, reviewable, and small, while avoiding custom tag management code.
