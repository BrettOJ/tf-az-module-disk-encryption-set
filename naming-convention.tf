module "disk_encryption_set_name" {
  source        = "git::https://github.com/BrettOJ/tf-az-module-naming-convention?ref=main"
  resource_type = "des"
  name_format   = "res_type|-|project_code|-|env|zone|tier|-|name"
  naming_convention_info = {
    "${var.naming_convention_info.name}" = {
      name_info = var.naming_convention_info
      tags      = var.tags
    }
  }
}


module "key_vault_key_name" {
  source        = "git::https://github.com/BrettOJ/tf-az-module-naming-convention?ref=main"
  resource_type = "kvk"
  name_format   = "res_type|-|project_code|-|env|zone|tier|-|name"
  naming_convention_info = {
    "${var.naming_convention_info.name}" = {
      name_info = var.naming_convention_info
      tags      = var.tags
    }
  }
}