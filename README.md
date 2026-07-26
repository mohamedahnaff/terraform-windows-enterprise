# Enterprise Windows Provisioning Automation

## Overview

This project provisions two private Windows Server EC2 instances in AWS by using Terraform, GitHub Actions, and ServiceNow integration.

## Architecture

ServiceNow catalog request and approval trigger GitHub Actions. GitHub Actions authenticates to AWS using OpenID Connect and runs Terraform. Terraform state is stored remotely in an encrypted and versioned Amazon S3 bucket with state locking enabled.

## Main Components

- ServiceNow Service Catalog
- ServiceNow approval workflow
- GitHub Actions
- GitHub OpenID Connect
- Terraform
- Amazon S3 remote backend
- AWS Key Management Service
- AWS Secrets Manager
- Amazon EC2 Windows instances
- AWS Systems Manager
- AWS CloudTrail

## Security Principles

- No AWS access keys are stored in GitHub
- GitHub Actions uses temporary AWS credentials through OIDC
- Terraform state is encrypted and versioned
- Windows instances are created in private subnets
- Public IP addresses are disabled
- RDP is not exposed to the internet
- EC2 instances are managed using AWS Systems Manager
- Sensitive values are not committed to Git

## Project Structure

- bootstrap/backend: Terraform backend bootstrap
- bootstrap/github-oidc: GitHub OIDC and IAM role
- infrastructure: Windows infrastructure configuration
- .github/workflows: GitHub Actions workflows
- scripts: Validation and integration scripts
- servicenow: ServiceNow integration scripts and documentation
- docs: Architecture and operational documentation

## Deployment Phases

1. Environment and repository preparation
2. S3 backend bootstrap
3. GitHub OIDC configuration
4. Windows infrastructure implementation
5. GitHub Actions pipeline
6. ServiceNow catalog and approval workflow
7. ServiceNow and GitHub integration
8. Testing, security validation and documentation
