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
- Terraform v1.5.7 or later
- Azure CLI
- GitHub account for CI/CD
## Setup Instructions
1. Configure Azure Storage Account for Terraform state:
```bashaz group create --name rg-platform-tfstate --location westeuropeaz storage account create --name staplatformtfstate --resource-group rg-platform-tfstate --sku Standard_LRSaz storage container create --name platform-tfstate --account-name staplatformtfstate```
2. Configure GitHub Secrets:
```AZURE_CLIENT_ID
AZURE_CLIENT_SECRET
AZURE_TENANT_ID
AZURE_MANAGEMENT_ID
AZURE_CONNECTIVITY_ID```
3. Clone repository and initialize Terraform:
```bashgit clone <repository-url>cd core-platform-caf-alz-publicterraform init```
## Deployment Order
1. Connectivity (Hub networking)
2. Management (Log Analytics)
3. Core (Management Groups & Policies)
## Usage Examples
### Deploy Connectivity Layer
```bashcd connectivityterraform initterraform planterraform apply```
### Deploy Custom Landing ZoneUpdate core/settings.core.tf with new landing zone definition and apply:
```bashcd coreterraform apply```
## Repository Structure```├── .github/workflows
# GitHub Actions CI/CD pipelines├── connectivity/
# Network hub configuration├── management/
# Logging and monitoring setup└── core/
# Management groups and policies
