output "storage_account_name" {
  description = "The name of the new Storage Account."
  value       = azurerm_storage_account.storage_account.name
}

output "containers" {
  description = "A list of all the blob containers that have been created (if specified)."
  value       = [for k in azurerm_storage_container.container : k.name]
}

output "shares" {
  description = "A list of all the File Shares that have been created (if specified)."
  value       = [for k in azurerm_storage_share.share : k.name]
}

output "queues" {
  description = "A list of all the storage queues that have been created (if specified)."
  value       = [for k in azurerm_storage_queue.queue : k.name]
}

output "tables" {
  description = "A list of all the storage tables that have been created (if specified)."
  value       = [for k in azurerm_storage_table.table : k.name]
}

output "id" {
  description = "The ID of the newly created Storage Account."
  value       = azurerm_storage_account.storage_account.id
}
output "storage_name" {
  description = "The primary blob endpoint."
  value       = azurerm_storage_account.storage_account.primary_blob_endpoint
}
output "primary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the primary location."
  value       = azurerm_storage_account.storage_account.primary_blob_endpoint
}
