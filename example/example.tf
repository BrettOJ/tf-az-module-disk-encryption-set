locals {
  akv_id = data.terraform_remote_state.lvl0.outputs.akv_merlion_output.id

  des_naming_convention_info = {
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

resource "azurerm_resource_group" "des_rg" {

  name     = "des-resources"
  location = "southeastasia"

}

module "azure_disk_encryption_set" {
  source                 = "git::https://github.com/BrettOJ/tf-az-module-disk-encryption-set?ref=main"
  resource_group_name    = azurerm_resource_group.des_rg.name
  location               = azurerm_resource_group.des_rg.location
  keyvault_id            = local.akv_id
  tags                   = local.tags
  naming_convention_info = local.des_naming_convention_info
  tenant_id              = "e08ace22-2c12-4de6-8b26-3a5d0f62aed1"
}