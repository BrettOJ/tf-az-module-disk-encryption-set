resource "azurerm_disk_encryption_set" "encryption_obj" {
  name                = module.disk_encryption_set_name.naming_convention_output[var.naming_convention_info.name].names.0
  resource_group_name = var.resource_group_name
  location            = var.location
  key_vault_key_id    = azurerm_key_vault_key.example.id
  tags                = module.disk_encryption_set_name.naming_convention_output[var.naming_convention_info.name].tags.0
  identity {
    type = "SystemAssigned"
  }
}
resource "azurerm_key_vault_key" "example" {
  name         = module.disk_encryption_set_name.naming_convention_output[var.naming_convention_info.name].names.0
  key_vault_id = var.keyvault_id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}