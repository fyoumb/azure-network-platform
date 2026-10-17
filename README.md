# azure-network-platform

Production-inspired Azure network platform built with Terraform, CI/CD, Python, and Ansible.

## Project Goal

Build a production-inspired Azure networking environment while developing hands-on skills in Infrastructure as Code, CI/CD, Python automation, and configuration management.

## Architecture

The platform will model a production-inspired Azure network architecture with:

- Hub-and-spoke network topology
- Hybrid connectivity using Azure ExpressRoute
- Centralized network and security controls
- Infrastructure as Code and automation

## Technology Stack

- Microsoft Azure
- Terraform
- GitHub Actions
- Python
- Ansible

## CI/CD

### Pull Request Checks

Pull requests are evaluated by GitHub Actions. When Terraform configuration or the Terraform CI workflow changes, the pipeline checks formatting, initializes Terraform, validates the configuration, and generates a preview plan.

### Deployment

The Terraform Deploy workflow is manually triggered from the main branch.

1. The plan job checks formatting, initializes and validates Terraform, and saves a deployment plan.
2. The saved plan is uploaded as a workflow artifact with one-day retention.
3. The apply job waits for approval through the protected dev environment.
4. The reviewer inspects the plan output before approving.
5. After approval, the apply job downloads and applies the saved plan.

Both jobs authenticate to Azure through OpenID Connect (OIDC), without stored client secrets. Terraform state is stored remotely in Azure Blob Storage.

The first deployment run successfully verified the approval gate and saved-plan execution with no infrastructure changes.

Deployment runs use the workflow-level concurrency group `terraform-deploy-dev`. Only one run in this group can be active at a time, covering planning, approval, and applying. With `cancel-in-progress: false`, a new run does not interrupt the active deployment.

Concurrency was verified by triggering two runs: the second waited before planning until the first completed, then required its own approval. Both plans reported no changes, and both deployments succeeded.

### Terraform State Locking

CI plans, deployment plans, and saved-plan applies use `-lock-timeout=5m`. If the remote state is locked, Terraform retries acquiring the lock for up to five minutes before failing.

Workflow concurrency coordinates deployment runs in GitHub Actions. Terraform state locking protects the shared state during Terraform operations, including operations started outside GitHub Actions. The state lock is released after planning; it is not held while waiting for deployment approval.

If lock acquisition times out, check for active Terraform operations before considering `terraform force-unlock`. Only release a confirmed abandoned lock. After recovery, generate and review a fresh plan before approving deployment.

PR checks and Terraform Deploy #5 passed with the timeout configured. The deployment applied the saved plan with 0 resources added, changed, or destroyed. Actual lock contention has not been tested.

### Drift Detection

The Terraform Drift Detection workflow runs daily at 10:17 UTC and can also be triggered manually from main. It authenticates to Azure through OIDC and runs a plan without applying changes.

The workflow uses `terraform plan -detailed-exitcode` with `-lock-timeout=5m`:

- Exit code 0: no changes proposed; the run succeeds.
- Exit code 1: planning failed; the run fails.
- Exit code 2: changes proposed; the run succeeds with a warning requiring review.

Results appear in the GitHub Actions run summary, with the full plan available in the job logs. A successful run can therefore still indicate changes requiring attention.

Proposed changes may reflect infrastructure drift or configuration changes that have not yet been deployed. Review the plan before deciding whether to update the configuration or restore the infrastructure through the approved deployment workflow. No automatic remediation is performed.

The `terraform-drift-dev` concurrency group coordinates drift-check runs independently of deployment runs. Terraform state locking protects against simultaneous operations on the shared state.

#### Review Tracking Issues

When Terraform proposes changes (exit code 2), the workflow creates a GitHub issue or updates the existing open issue identified by the hidden marker `<!-- terraform-drift-dev -->`. This avoids creating a new issue for each run while a finding remains open.

The issue links to the latest workflow run, and the run summary links back to the issue. The workflow uses `issues: write` permission to create and update issues.

The automation replaces the issue body when updating it, so record investigation and resolution notes in comments.

A plan reporting no changes does not automatically close an existing issue. After reviewing the finding, resolving it, and verifying a plan with no proposed changes, manually close the issue.

Validation:

- Run 1 reported no changes.
- After changing the hub resource group's `ManagedBy` tag from `terraform` to `manual-test` in Azure, run 2 proposed restoring it to `terraform` and displayed a warning.
- After manually restoring the tag, run 3 reported no changes.
- Scheduled run 4 on October 16, 2026, completed successfully and reported no changes.
- Run 5 reported no changes and skipped the issue tracking step.
- After repeating the tag change, run 6 created issue [34](https://github.com/fyoumb/azure-network-platform/issues/34).
- Run 7 detected the persistent change and updated the same issue without creating a duplicate.
- After manually restoring the tag, run 8 reported no changes and skipped the issue tracking step. Issue 34 remained open until manually closed as completed with a resolution comment.

## Engineering Principles

- Infrastructure changes are version controlled
- Changes are reviewed through pull requests
- Infrastructure is deployed through automated workflows
- Network architecture is designed for resilience and security

