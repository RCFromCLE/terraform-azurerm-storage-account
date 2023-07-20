# #######################################################
# Commmon variables. Usually required across ALL modules.
# #######################################################
variable "tags" {
  description = "tags to apply to the new resources"
  type        = map(string)
  default     = null
}
variable "location" {
  description = "The Azure Region of where the Storage Account & Private Endpoint are to be created."
  type        = string
  default     = "South Central US"
}

# ##########################################
# Variables for use within this module only.
# ##########################################

# storage account features
variable "sa_resource_group_name" {
  description = "The name of a Resource Group to deploy the new Storage Account into."
  type        = string
}
variable "repl_type" {
  description = "The replication type required for the new Storage Account. Options are LRS; GRS; RAGRS; ZRS"
  type        = string
  default     = "GRS"
  # add validation
}
variable "account_tier" {
  description = "The Storage Tier for the new Account. Options are 'Standard' or 'Premium'"
  type        = string
  default     = "Standard"
}
variable "storage_account_name" {
  description = "The name to assign to the new Storage Account."
  type        = string
}
variable "blob_containers" {
  type        = list(any)
  description = "List all the blob containers to create."
  default     = []
}
variable "datalake_v2" {
  description = "Enabled Hierarchical name space for Data Lake Storage Gen 2"
  type        = bool
  default     = false
}
variable "storage_shares" {
  type        = list(string)
  description = "A list of Shares to create within the new Storage Acount."
  default     = []
}
variable "storage_queues" {
  type        = list(string)
  description = "A list of Storage Queues to be created."
  default     = []
}
variable "storage_tables" {
  type        = list(string)
  description = "A list of Storage Tables to be created."
  default     = []
}
############################# security and networking settings ###############################
variable "default_action" {
  type        = string
  description = "Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow."
  default     = "Deny"
}
variable "allowed_public_ip" {
  type        = list(string)
  description = "A list of public IP or IP ranges in CIDR Format. Private IP Addresses are not permitted."
  default     = []
}
variable "bypass_services" {
  type        = list(string)
  description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices. Empty list to remove it."
  default     = []
}
variable "allowed_subnet_ids" {
  type        = list(string)
  description = "A list of virtual network subnet ids to to secure the storage account."
  default     = []
}
variable "enable_https_traffic_only" {
  type        = bool
  description = "Enables https traffic only to storage service if set to true."
  default     = true
}
variable "allowed_copy_scope" {
  description = "Scope for the copy allowed in the storage account. Possible values are 'AAD' and 'PrivateLink'."
  type        = string
  default = "AAD"
}
 variable "allow_nested_items_to_be_public" {
  description = "Allow or disallow public access to all blobs or containers in the storage account."
  type        = bool
  default     = false
}
variable "ip_rules" {
  description = "List of public IP or IP ranges in CIDR format. Private IP address ranges are not allowed."
  type        = list(string)
  default     = []
}
variable "virtual_network_subnet_ids" {
  description = "List of virtual network subnet ids to secure the storage account."
  type        = list(string)
  default     = []
}
variable "tls_ver" {
  description = "Minimum version of TLS that must be used to connect to the storage account"
  type        = string
  default     = "TLS1_2"
}
variable "cross_tenant_replication" {
  description = "Enable cross tenant replication"
  type        = bool
  default     = false
}
##########################################Start of blob and container properties############################################
variable "delete_retention_policy_days" {
  type        = number
  description = "Specifies the number of days that the deleted item should be retained. The minimum specified value can be 1 and the maximum value can be 365."
  default     = 14
}
variable "container_delete_retention_policy_days" {
  type = number
  description = "Specifies the number of days that the deleted container should be retained. The minimum specified value can be 1 and the maximum value can be 365."
  default     = 14
}
variable "versioning_enabled" {
  description = "Enables versioning for blobs in the storage account."
  type        = bool
  default     = false
}