subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
## Pre Defined KV for storing secret
#kv_dev_Name = "dev-thoughtworks-demo-kv" #### We have to change as per env
## VNET - SUBNET
rg_name            = "ThoughtWorks" ## We have to change as per env
location           = "eastus2"
vnet_Name          = "vnet-thoughtworks"
vnet_Address       = "10.0.0.0/16"
subnet_NameList    = ["subnet1"]
subnet_AddressList = ["10.0.1.0/24"]

### Linux Virtual Machine Deployment

virtual_machine_Usr    = "virtual-machine-user"
virtual_machine_Passwd = "virtual-machine-password"
public_ip              = "public_ip_linux"
pip_allocation         = "Dynamic"
vm_nic                 = "linux_vm_nic"
ip_configuration       = "ip_config"
vm_name                = "MediaWiki3"
vm_size                = "Standard_B2s"
vm_username            = "azureuser"
#vm_password            = "" ## Fetched from KV.
vm_image_publisher     = "OpenLogic"
vm_image_offer         = "CentOS"
vm_image_sku           = "8_5-gen2"
vm_image_version       = "latest"
vm_os_disk_strg_type   = "Standard_LRS"
vm_os_disk_caching     = "ReadWrite"
