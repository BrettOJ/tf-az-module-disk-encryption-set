locals {
  akv_id = data.terraform_remote_state.lvl0.outputs.akv_output.id

  naming_convention_info = {
    name         = "001"
    project_code = "ml"
    env          = "de"
    zone         = "in"
    agency_code  = "boj"
    tier         = "pp"
  }

  tags = {
    createdBy = "Terraform"
    project   = "boj"
    Owner     = "BrettOJ"
  }

}
module "resource_groups" {
  source = "git::https://github.com/BrettOJ/tf-az-module-resource-group?ref=main"
  resource_groups = {
    1 = {
      name                   = var.resource_group_name
      location               = var.location
      naming_convention_info = local.naming_convention_info
      tags = {
      }
    }
  }
}

module "azure_disk_encryption_set" {
  source                 = "git::https://github.com/BrettOJ/tf-az-module-disk-encryption-set?ref=main"
  resource_group_name    = module.resource_groups.rg_output[1].name
  location               = var.location
  key_vault_key_id            = var.key_vault_key_id
  tags                   = local.tags
  naming_convention_info = local.naming_convention_info
  managed_hsm_key_id = var.managed_hsm_key_id
  auto_key_rotation_enabled = var.auto_key_rotation_enabled
  encryption_type          = var.encryption_type
  federated_client_id      = var.federated_client_id
  tenant_id                = var.tenant_id
  keyvault_id              = local.akv_id
  identity {
    type = var.identity.type
    identity_ids = var.identity.identity_ids
  }
}
