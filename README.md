# Azure Landing Zones (ALZ) Enterprise Scale Platform
This repository contains the Infrastructure as Code (IaC) implementation of the Azure Landing Zone architecture using Terraform, following the Cloud Adoption Framework (CAF) Enterprise Scale methodology.
## Architecture OverviewThe platform is divided into three main components:
- **Connectivity**: Hub networks, networking policies, and DDoS protection
- **Management**: Log Analytics workspace, security center configuration
- **Core**: Management group hierarchy, custom landing zones, and policy assignments
## Features
- Multi-subscription architecture with separate subscriptions for connectivity, management, and workloads
- Automated deployment using GitHub Actions CI/CD pipelines
- Remote state management using Azure Storage Account
- Hub network deployment with optional DDoS protection
- Centralized logging and monitoring setup
- Custom landing zones with granular policy controls
## Prerequisites
- Azure Subscription(s)
- Terraform v1.8.5 or later
- Azure CLI
- GitHub account for CI/CD
## Setup Instructions
1. Configure Azure Storage Account for Terraform state:
TBD

2. Configure GitHub OIDC Federation based on Environment Profiles:
```
AZURE_CLIENT_ID
AZURE_TENANT_ID
AZURE_SUBSCRIPTION_ID
```
3. Clone repository and initialize Terraform:
```bash
git clone <repository-url>
cd atlz-platform
terraform init
```
## Deployment Order
1. Connectivity (Hub networking)
2. Management (Log Analytics)
3. Identity (Management Groups & Policies)



## Repository Structure
```
├── .github/workflows     # GitHub Actions CI/CD pipelines
├── 11-connectivity/      # Network hub configuration
├── 12-management/        # Logging and monitoring setup
└── 13-identity/          # Management groups and policies
```
