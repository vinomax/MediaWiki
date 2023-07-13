variable "keyvault_Name" {
  type        = string
  default     = ""
  description = "keyvault name"
  validation {
    condition     = length(var.keyvault_Name) > 6 && can(regex("dev", lower(var.keyvault_Name)))
    error_message = "The keyvault_Name must be valied name, should contain dev. This can be configured in variables.tf file to streamline according to the environment."
  }
}
variable "keyvault_SKU" {
  type        = string
  default     = "standard"
  description = "SKU used for Key Vault. Possible values are standard and premium"
}
variable "location" {
  type        = string
  default     = "eastus2"
  description = "location for key-valut deployment"
  validation {
    condition     = contains(["eastus2", "centralus"], lower(var.location))
    error_message = "Only East US2 and Central US Azure Regions are supported."
  }
}
variable "rg_name" {
  type        = string
  default     = ""
  description = "Resource group name to deploy the resources"
}