resource "azurerm_virtual_network" "my_terraform_network" {
  name                = var.vnet_Name
  resource_group_name = var.rg_name
  location            = var.location
  address_space       = [var.vnet_Address]
}

resource "azurerm_subnet" "subnet" {
  count                                          = length(var.subnet_NameList)
  name                                           = var.subnet_NameList[count.index]
  virtual_network_name                           = azurerm_virtual_network.my_terraform_network.name
  resource_group_name                            = var.rg_name
  address_prefixes                               = [var.subnet_AddressList[count.index]]
  enforce_private_link_endpoint_network_policies = false
  enforce_private_link_service_network_policies  = false
}