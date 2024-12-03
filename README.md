# tf-az-module-disk-encryption-set
Terraform Module for creating a disk encryption set 

Manages a Disk Encryption Set.

## [Example Usage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#example-usage)

```hcl
data "azurerm_client_config" "current" {} resource "azurerm_resource_group" "example" { name = "example-resources" location = "West Europe" } resource "azurerm_key_vault" "example" { name = "des-example-keyvault" location = azurerm_resource_group.example.location resource_group_name = azurerm_resource_group.example.name tenant_id = data.azurerm_client_config.current.tenant_id sku_name = "premium" enabled_for_disk_encryption = true purge_protection_enabled = true } resource "azurerm_key_vault_key" "example" { name = "des-example-key" key_vault_id = azurerm_key_vault.example.id key_type = "RSA" key_size = 2048 depends_on = [ azurerm_key_vault_access_policy.example-user ] key_opts = [ "decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey", ] } resource "azurerm_disk_encryption_set" "example" { name = "des" resource_group_name = azurerm_resource_group.example.name location = azurerm_resource_group.example.location key_vault_key_id = azurerm_key_vault_key.example.id identity { type = "SystemAssigned" } } resource "azurerm_key_vault_access_policy" "example-disk" { key_vault_id = azurerm_key_vault.example.id tenant_id = azurerm_disk_encryption_set.example.identity[0].tenant_id object_id = azurerm_disk_encryption_set.example.identity[0].principal_id key_permissions = [ "Create", "Delete", "Get", "Purge", "Recover", "Update", "List", "Decrypt", "Sign", ] } resource "azurerm_key_vault_access_policy" "example-user" { key_vault_id = azurerm_key_vault.example.id tenant_id = data.azurerm_client_config.current.tenant_id object_id = data.azurerm_client_config.current.object_id key_permissions = [ "Create", "Delete", "Get", "Purge", "Recover", "Update", "List", "Decrypt", "Sign", "GetRotationPolicy", ] } resource "azurerm_role_assignment" "example-disk" { scope = azurerm_key_vault.example.id role_definition_name = "Key Vault Crypto Service Encryption User" principal_id = azurerm_disk_encryption_set.example.identity[0].principal_id }
```

## [Example Usage with Automatic Key Rotation Enabled](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#example-usage-with-automatic-key-rotation-enabled)

```hcl
data "azurerm_client_config" "current" {} resource "azurerm_resource_group" "example" { name = "example-resources" location = "West Europe" } resource "azurerm_key_vault" "example" { name = "des-example-keyvault" location = azurerm_resource_group.example.location resource_group_name = azurerm_resource_group.example.name tenant_id = data.azurerm_client_config.current.tenant_id sku_name = "premium" enabled_for_disk_encryption = true purge_protection_enabled = true } resource "azurerm_key_vault_key" "example" { name = "des-example-key" key_vault_id = azurerm_key_vault.example.id key_type = "RSA" key_size = 2048 depends_on = [ azurerm_key_vault_access_policy.example-user ] key_opts = [ "decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey", ] } resource "azurerm_disk_encryption_set" "example" { name = "des" resource_group_name = azurerm_resource_group.example.name location = azurerm_resource_group.example.location key_vault_key_id = azurerm_key_vault_key.example.versionless_id auto_key_rotation_enabled = true identity { type = "SystemAssigned" } } resource "azurerm_key_vault_access_policy" "example-disk" { key_vault_id = azurerm_key_vault.example.id tenant_id = azurerm_disk_encryption_set.example.identity[0].tenant_id object_id = azurerm_disk_encryption_set.example.identity[0].principal_id key_permissions = [ "Create", "Delete", "Get", "Purge", "Recover", "Update", "List", "Decrypt", "Sign", ] } resource "azurerm_key_vault_access_policy" "example-user" { key_vault_id = azurerm_key_vault.example.id tenant_id = data.azurerm_client_config.current.tenant_id object_id = data.azurerm_client_config.current.object_id key_permissions = [ "Create", "Delete", "Get", "Purge", "Recover", "Update", "List", "Decrypt", "Sign", "GetRotationPolicy", ] } resource "azurerm_role_assignment" "example-disk" { scope = azurerm_key_vault.example.id role_definition_name = "Key Vault Crypto Service Encryption User" principal_id = azurerm_disk_encryption_set.example.identity[0].principal_id }
```

## [Argument Reference](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#argument-reference)

The following arguments are supported:

-   [`name`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#name-1) - (Required) The name of the Disk Encryption Set. Changing this forces a new resource to be created.
    
-   [`resource_group_name`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#resource_group_name-1) - (Required) Specifies the name of the Resource Group where the Disk Encryption Set should exist. Changing this forces a new resource to be created.
    
-   [`location`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#location-1) - (Required) Specifies the Azure Region where the Disk Encryption Set exists. Changing this forces a new resource to be created.
    
-   [`identity`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#identity-1) - (Required) An `identity` block as defined below.
    
-   [`key_vault_key_id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#key_vault_key_id-1) - (Optional) Specifies the URL to a Key Vault Key (either from a Key Vault Key, or the Key URL for the Key Vault Secret). Exactly one of `managed_hsm_key_id`, `key_vault_key_id` must be specified.
    

-   [`managed_hsm_key_id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#managed_hsm_key_id-1) - (Optional) Key ID of a key in a managed HSM. Exactly one of `managed_hsm_key_id`, `key_vault_key_id` must be specified.
    
-   [`auto_key_rotation_enabled`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#auto_key_rotation_enabled-1) - (Optional) Boolean flag to specify whether Azure Disk Encryption Set automatically rotates the encryption Key to latest version or not. Possible values are `true` or `false`. Defaults to `false`.
    

-   [`encryption_type`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#encryption_type-1) - (Optional) The type of key used to encrypt the data of the disk. Possible values are `EncryptionAtRestWithCustomerKey`, `EncryptionAtRestWithPlatformAndCustomerKeys` and `ConfidentialVmEncryptedWithCustomerKey`. Defaults to `EncryptionAtRestWithCustomerKey`. Changing this forces a new resource to be created.
    
-   [`federated_client_id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#federated_client_id-1) - (Optional) Multi-tenant application client id to access key vault in a different tenant.
    
-   [`tags`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#tags-1) - (Optional) A mapping of tags to assign to the Disk Encryption Set.
    

___

An `identity` block supports the following:

-   [`type`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#type-1) - (Required) The type of Managed Service Identity that is configured on this Disk Encryption Set. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both).
    
-   [`identity_ids`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#identity_ids-1) - (Optional) A list of User Assigned Managed Identity IDs to be assigned to this Disk Encryption Set.
    

## [Attributes Reference](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#attributes-reference)

In addition to the Arguments listed above - the following Attributes are exported:

-   [`id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#id-1) - The ID of the Disk Encryption Set.
    
-   [`key_vault_key_url`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#key_vault_key_url-1) - The URL for the Key Vault Key or Key Vault Secret that is currently being used by the service.
    

___

An `identity` block exports the following:

-   [`principal_id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#principal_id-1) - The (Client) ID of the Service Principal.
    
-   [`tenant_id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#tenant_id-2) - The ID of the Tenant the Service Principal is assigned in.
    

## [Timeouts](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#timeouts)

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

-   [`create`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#create-1) - (Defaults to 60 minutes) Used when creating the Disk Encryption Set.
-   [`update`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#update-1) - (Defaults to 60 minutes) Used when updating the Disk Encryption Set.
-   [`read`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#read-1) - (Defaults to 5 minutes) Used when retrieving the Disk Encryption Set.
-   [`delete`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#delete-1) - (Defaults to 60 minutes) Used when deleting the Disk Encryption Set.

## [Import](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set#import)

Disk Encryption Sets can be imported using the `resource id`, e.g.

```shell
terraform import azurerm_disk_encryption_set.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.Compute/diskEncryptionSets/encryptionSet1
```
