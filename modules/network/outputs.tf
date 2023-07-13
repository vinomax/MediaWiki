output "vnet_Name" {
  value = azurerm_virtual_network.my_terraform_network.name
}
output "vnet_Address" {
  value = azurerm_virtual_network.my_terraform_network.address_space
}
output "vnet_Id" {
  value = azurerm_virtual_network.my_terraform_network.id
}

output "subnet_Name" {
  value = azurerm_subnet.subnet.*.name
}
output "subnet_Id" {
  value = azurerm_subnet.subnet.*.id
}
output "subnet_CIDRAddress" {
  value = azurerm_subnet.subnet.*.address_prefixes
}
