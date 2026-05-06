# AMS Monitoring Infrastructure Documentation

This document describes the infrastructure setup for AMS Monitoring. The infrastructure is deployed in Azure Cloud, where we create core resources like Resource Groups (RG) and Storage Accounts.

## Infrastructure Creation

Using the AMS Monitoring Terraform module, the following resources are created:

### Resource Group (RG)
- Name: `rg-ams-monitoring-{location_short}-{env}`
- Location: As specified (e.g., "West Europe", "East US")
- Purpose: Acts as a logical container to group and manage all related resources efficiently.

### Storage Account
- Name: `st1amsmonitoring{location_short}{env}`
- Resource Group: Created inside the above Resource Group
- Location: Same as Resource Group
- Account Tier: Defined via variable (Standard or Premium)
- Replication Type: Defined via variable (LRS, GRS, etc.)
- Purpose: Used to store monitoring data such as logs and metrics.

## Terraform State Management
- Terraform state is stored locally on the machine.
- State file name: `terraform.tfstate`
- This file tracks the current state of infrastructure to ensure proper updates.
- Backend: Local backend (default configuration)

## Variables
The module requires the following input variables:

- `env` → Environment name (e.g., `dev`, `stg`, `prod`, `test`)
- `location` → Full Azure region name
- `location_short` → Short region code (e.g., `weu` for West Europe)
- `tags` → Tags applied to resources
- `account_replication_type` → Storage replication type
- `account_tier` → Storage performance tier

## Usage
Call the module inside `main.tf`:

module "ams-monitoring" {
  source = "./modules/ams-monitoring"

  # Pass required variables here
}

## Multi-Environment Deployment

This is a multi-environment infrastructure setup, meaning you can deploy the same code to different environments like:

- `DEV`
- `STG` (Staging)
- `PROD`
- `TEST`

## How to Deploy Infrastructure
Navigate to your IAC folder, then run the following commands based on the environment:

### Step 1: Initialize Terraform
bash
terraform init

### Step 2: Deploy to a Specific Environment

#### Example: Deploy to DEV
```bash
terraform plan --var-file="env/dev/main.tfvars"
terraform apply --var-file="env/dev/main.tfvars"
```

#### Example: Deploy to PROD
```bash
terraform plan --var-file="env/prod/main.tfvars"
terraform apply --var-file="env/prod/main.tfvars"
```

## Important Note
- Always use the correct variable file (`.tfvars`) for the target environment.
- The environment is controlled only through the `--var-file` parameter.
- Same code is reused across all environments — only configuration changes.