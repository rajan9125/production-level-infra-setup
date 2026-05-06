terraform {
  backend "local" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.47.0"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
  }
  required_version = "1.11.2"
}

provider "azurerm" {
  features {}

  subscription_id     = var.subscription_id
  storage_use_azuread = true

}

module "ams-monitoring" {
  source                   = "./modules/ams-monitoring"
  env                      = var.env
  tags                     = var.tags
  location                 = var.location
  location_short           = var.location_short
  account_replication_type = var.account_replication_type
  account_tier             = var.account_tier
}
