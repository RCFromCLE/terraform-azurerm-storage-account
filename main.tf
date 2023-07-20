/**
 * # terraform-azurerm-storage-account
 *
 * Creates a new Storage Account using security best practices configuration with option to create containers and Blob Private Endpoint.
 */
# --------------------------------------------------------------
# Create Storage Account
# --------------------------------------------------------------
resource "azurerm_storage_account" "storage_account" {
  name                             = var.storage_account_name
  resource_group_name              = var.sa_resource_group_name
  location                         = var.location
  account_tier                     = var.account_tier
  account_replication_type         = var.repl_type
  is_hns_enabled                   = var.datalake_v2
  tags                             = var.tags
  min_tls_version                  = var.tls_ver
  enable_https_traffic_only        = var.enable_https_traffic_only
  cross_tenant_replication_enabled = var.cross_tenant_replication
  allowed_copy_scope               = var.allowed_copy_scope
  allow_nested_items_to_be_public  = var.allow_nested_items_to_be_public
  blob_properties {
    container_delete_retention_policy {
      days = var.container_delete_retention_policy_days
    }
    delete_retention_policy {
      days = var.delete_retention_policy_days
    }
    versioning_enabled = var.versioning_enabled
  }
}

# --------------------------------------------------------------
# Create Blob Containers
# --------------------------------------------------------------
resource "azurerm_storage_container" "container" {
  for_each              = toset(var.blob_containers)
  name                  = each.key
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
  depends_on = [
    azurerm_storage_account.storage_account,
  ]
}

# --------------------------------------------------------------
# Create Storage Shares
# --------------------------------------------------------------

resource "azurerm_storage_share" "share" {
  for_each             = toset(var.storage_shares)
  name                 = each.key
  storage_account_name = azurerm_storage_account.storage_account.name
  quota                = 50
  access_tier          = "Hot"
  enabled_protocol     = "SMB"
}

# --------------------------------------------------------------
# Create Storage Tables
# --------------------------------------------------------------

resource "azurerm_storage_table" "table" {
  for_each             = toset(var.storage_tables)
  name                 = each.key
  storage_account_name = azurerm_storage_account.storage_account.name
}

# --------------------------------------------------------------
# Create Storage Queues
# --------------------------------------------------------------

resource "azurerm_storage_queue" "queue" {
  for_each             = toset(var.storage_queues)
  name                 = each.key
  storage_account_name = azurerm_storage_account.storage_account.name
}

# --------------------------------------------------------------
# Network rules
# --------------------------------------------------------------
resource "azurerm_storage_account_network_rules" "net_rules" {
  storage_account_id         = azurerm_storage_account.storage_account.id
  default_action             = var.default_action
  ip_rules                   = var.allowed_public_ip
  virtual_network_subnet_ids = var.allowed_subnet_ids
  bypass                     = var.bypass_services
}

