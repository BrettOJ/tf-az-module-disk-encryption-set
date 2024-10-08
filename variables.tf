
variable "resource_group_name" {
  type        = string
  description = "(Required) Specifies the name of the Resource Group in which the Virtual Machine should exist. Changing this forces a new resource to be created."
}
variable "key_vault_key_id" {
  type        = string
  description = "(Required) Specifies the azure key vault id."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the Azure Region where the Virtual Machine exists. Changing this forces a new resource to be created."
}
variable "naming_convention_info" {
  description = "(Required) Specify the naming convention information to the resource."
  type = object({
    name         = string
    agency_code  = string
    project_code = string
    env          = string
    zone         = string
    tier         = string
  })
}

variable "tags" {
  type        = map(string)
  description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}

variable "tenant_id" {
  type        = string
  default     = null
  description = "If this value is set then Key Vault access policy will be set"
}

variable "managed_hsm_key_id" {
  type        = string
  default     = null
  description = "Specifies the managed hsm key id."
}

variable "auto_key_rotation_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether Azure Disk Encryption Set automatically rotates the encryption Key to latest version or not."
}

variable "encryption_type" {
  type        = string
  default     = "EncryptionAtRestWithCustomerKey"
}

variable "federated_client_id" {
  type        = string
  default     = null
  description = "Specifies the multi-tenant application client id to access key vault in a different tenant."
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = list(string)
  })
  description = "Specifies the identity block as defined below."
}

variable "keyvault_id" {
  type        = string
  description = "Specifies the azure key vault id."
}
