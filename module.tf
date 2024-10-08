resource "azurerm_disk_encryption_set" "encryption_obj" {
  name                = module.disk_encryption_set_name.naming_convention_output[var.naming_convention_info.name].names.0
  resource_group_name = var.resource_group_name
  location            = var.location
  key_vault_key_id    = azurerm_key_vault_key.example.id
  tags                = module.disk_encryption_set_name.naming_convention_output[var.naming_convention_info.name].tags.0
  managed_hsm_key_id = var.managed_hsm_key_id
  auto_key_rotation_enabled = var.auto_key_rotation_enabled
  encryption_type          = var.encryption_type
  federated_client_id      = var.federated_client_id
  identity {
    type = var.identity.type
    identity_ids = var.identity.identity_ids
  }
}

resource "azurerm_key_vault_key" "example" {
  name         = module.key_vault_key_name.naming_convention_output[var.naming_convention_info.name].names.0
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