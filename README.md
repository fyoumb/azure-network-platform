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

## Engineering Principles

- Infrastructure changes are version controlled
- Changes are reviewed through pull requests
- Infrastructure is deployed through automated workflows
- Network architecture is designed for resilience and security

