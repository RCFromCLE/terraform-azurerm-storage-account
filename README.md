terraform-azurerm-storage-account
========================================

This Terraform module creates a storage account using security best practices as defaults, with options for additional features such as Blob Containers, Storage Shares, Storage Tables, Storage Queues, and custom Network Rules.

Usage
-----

```hcl
`module "storage-account" {
  source               = "./terraform-azurerm-storage-account"
  sa_resource_group_name = "rgnamehere"
  storage_account_name = "storageaccountnamehere"
  location             = data.azurerm_resource_group.rg.location
}`
```

Security Defaults:
-----------------------------------------

1.  Enforced HTTPS Traffic: This module enables HTTPS traffic only by default. It's configured using the `enable_https_traffic_only` variable.

2.  TLS Version Control: The module uses a default minimum TLS version of 1.2 (specified by `tls_ver`), which helps to mitigate risks associated with older TLS versions.

3.  IP-Based and VNet-Based Network Rules: This module supports network rules that restrict access based on IP addresses and Virtual Network (VNet) Subnet IDs. This feature allows you to limit access to your storage account to specified IPs and VNets, effectively securing your storage account from unauthorized access. The default IPs in the rules are "" (specified by `allowed_public_ip`).

4.  Deny by Default: The module's default action for network rules is "Deny" (specified by `default_action`). This setting is a security best practice: it means that unless a network traffic source matches one of your specified IP or VNet rules, it will not be granted access.

5.  Secure Copy Scope: The module defaults to allowing copy scope to 'AAD', specified by the `allowed_copy_scope` variable. This setting limits data copy operations to within the same Azure Active Directory tenant, adding another layer of data protection.

6.  Cross Tenant Replication: The `cross_tenant_replication` variable enables you to control cross tenant replication. This setting is set to `false` by default, preventing data replication across different tenants, which helps maintain data isolation and security.

7.  Data Retention Policies: The module has settings (`delete_retention_policy_days` and `container_delete_retention_policy_days`) that retain deleted items and containers for a default period of 14 days. This feature can help protect against accidental data loss.

8.  Container Access Type: This module defaults to creating blob containers with "private" access. This means that the data in these containers is not publicly accessible and requires authentication.

9.  Data Versioning: The module provides an option (`versioning_enabled`) to enable versioning for blobs in the storage account, which can protect against unintended overwrites, deletions, and corruptions by storing previous versions of blobs.

10. Disallow Public Access to Nested Items: The variable `allow_nested_items_to_be_public` is set to false by default, ensuring that public access to all blobs or containers in the storage account is disallowed.


Inputs
------

The following input variables are required:

-   `sa_resource_group_name` (required) - The name of a Resource Group to deploy the new Storage Account into.
-   `storage_account_name` (required) - The name to assign to the new Storage Account.
-   `location` (required) - The Azure Region where the Storage Account & Private Endpoint are to be created.

Optional variables, with default values:

-   `account_tier` (optional) - The Storage Tier for the new Account. Options are 'Standard' or 'Premium'. Default: 'Standard'.
-   `repl_type` (optional) - The replication type required for the new Storage Account. Options are LRS, GRS, RAGRS, ZRS. Default: 'GRS'.
-   `datalake_v2` (optional) - Enable Hierarchical name space for Data Lake Storage Gen 2. Default: false.
-   `blob_containers` (optional) - List all the blob containers to create. Default: [].
-   `storage_shares` (optional) - A list of Shares to create within the new Storage Acount. Default: [].
-   `storage_queues` (optional) - A list of Storage Queues to be created. Default: [].
-   `storage_tables` (optional) - A list of Storage Tables to be created. Default: [].
-   `default_action` (optional) - Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow. Default: 'Deny'.
-   `allowed_public_ip` (optional) - A list of public IP or IP ranges in CIDR Format. Private IP Addresses are not permitted. Default: [].
-   `bypass_services` (optional) - Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices. Empty list to remove it. Default: [].
-   `allowed_subnet_ids` (optional) - A list of virtual network subnet ids to to secure the storage account. Default: [].
-   `enable_https_traffic_only` (optional) - Enables https traffic only to storage service if set to true. Default: true.
-   `allowed_copy_scope` (optional) - Scope for the copy allowed in the storage account. Possible values are 'AAD' and 'PrivateLink'. Default: 'AAD'.
-   `allow_nested_items_to_be_public` (optional) - Allow or disallow public access to all blobs or containers in the storage account. Default: false.
-   `tls_ver` (optional) - Minimum version of TLS that must be used to connect to the storage account. Default: 'TLS1_2'.
-   `cross_tenant_replication` (optional) - Enable cross tenant replication. Default: false.
-   `delete_retention_policy_days` (optional) - Specifies the number of days that the deleted item should be retained. The minimum specified value can be 1 and the maximum value can be 365. Default: 14.
-   `container_delete_retention_policy_days` (optional) - Specifies the number of days that the deleted container should be retained. The minimum specified value can be 1 and the maximum value can be 365. Default: 14.
-   `versioning_enabled` (optional) - Enable versioning for blobs in the storage account. Default: false.

Outputs
-------

The following output variables are returned after the module execution:

-   `storage_account_name` - The name of the new Storage Account.
-   `containers` - A list of all the blob containers that have been created (if specified).
-   `shares` - A list of all the File Shares that have been created (if specified).
-   `queues` - A list of all the storage queues that have been created (if specified).
-   `tables` - A list of all the storage tables that have been created (if specified).
-   `id` - The ID of the newly created Storage Account.
-   `storage_name` - The primary blob endpoint.
-   `primary_blob_endpoint` - The endpoint URL for blob storage in the primary location.