resource "azurerm_resource_group" "ams_monitoring_rg" {
  name     = "rg-ams-monitoring-${var.location_short}-${var.env}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_storage_account" "ams_storage_account" {
  name                            = "st1amsmonitoring${var.location_short}${var.env}"
  resource_group_name             = azurerm_resource_group.ams_monitoring_rg.name
  location                        = var.location
  account_replication_type        = var.account_replication_type
  account_tier                    = var.account_tier
  min_tls_version                 = "TLS1_0"
}
