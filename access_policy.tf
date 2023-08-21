resource "azurerm_key_vault_access_policy" "des_kv_policy" {
  key_vault_id = var.keyvault_id

  tenant_id       = var.tenant_id
  object_id       = lookup(element(azurerm_disk_encryption_set.encryption_obj.identity, 0), "principal_id")
  key_permissions = ["WrapKey", "Get", "UnwrapKey"]
  depends_on      = [azurerm_disk_encryption_set.encryption_obj]
}
