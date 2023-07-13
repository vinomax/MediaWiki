data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_Name
  resource_group_name = var.rg_name
  location            = var.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.keyvault_SKU
  enabled_for_deployment = true
  enabled_for_disk_encryption = true
  enabled_for_template_deployment = true
  access_policy {
      tenant_id = "${data.azurerm_client_config.current.tenant_id}"

      key_permissions = ["Create", "Get", "List", "Purge", "Recover",]
      secret_permissions = ["Get", "List", "Purge", "Recover", "Set"]
      certificate_permissions = ["Create", "Get", "List", "Purge", "Recover", "Update"]
  }
  
  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }

} 