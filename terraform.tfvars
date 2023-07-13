subscription_id = "3c619550-14a0-4006-a7a3-5f0401873fca"
## Pre Defined KV for storing secret
kv_dev_Name = "dev-thoughtworks-demo-kv" #### We have to change as per env
## VNET - SUBNET
rg_name            = "ThoughtWorks" ## We have to change as per env
location           = "eastus2"
vnet_Name          = "vnet-thoughtworks"
vnet_Address       = "10.0.0.0/16"
subnet_NameList    = ["subnet1"]
subnet_AddressList = ["10.0.1.0/24"]
wiki_pass          = "wiki-user-password"
mysql_root_pass    = "mysql-root-password"

### Linux Virtual Machine Deployment

virtual_machine_Usr    = "virtual-machine-user"
virtual_machine_Passwd = "virtual-machine-password"
public_ip              = "public_ip_linux"
pip_allocation         = "Dynamic"
vm_nic                 = "linux_vm_nic"
ip_configuration       = "ip_config"
vm_name                = "MediaWiki"
vm_size                = "Standard_B2s"
vm_username            = "azureuser"
#vm_password            = "" ## Fetched from KV.
vm_image_publisher     = "OpenLogic"
vm_image_offer         = "CentOS"
vm_image_sku           = "8_5-gen2"
vm_image_version       = "latest"
vm_os_disk_strg_type   = "Standard_LRS"
vm_os_disk_caching     = "ReadWrite"
vm_public_key          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYP2Wb0jwWnYXp4h97QhqdDDsjzZGR9/iOuu90LZRFMFaY0BMVIR4VUQlrus7LrEg0nl5Ffuce66HuORkeIR2miMRR9JWKAWZCGujdcIHruNpmqrnEPDvzCx8wYlLlnopDCs+H1vqsmP6nZX4TZIevBnBiaH8HI7yJ3ZP4VfOTo46xhBO/qT7LjvrczLVuJo7ytXAl/slqlZZn4LcoLhoSFnwSFIki26iOlp1F3Kl752LIX+ebapu1k+F5M5mj/fQ4HfPw95CBVTeF05h3PDtIF7KcscjjoQyqvbus6r4k8qmRF68wbtZ5dMETvLVFSbB9czGAr9AmBXDYXpPOvqSrFsTOvSmIuO4TlB+ZKg+4gVb8sd3/cMicoXi/MDJFFBDQCk/av/84xUtrOAHMGYkdjkGOEsG8M8nZaB8JWJabhlYfjsNGajoFZAq/Hun/sHdK02UOtp6YT5htpyZZmNzMNTaQ4hwdrVaFvPS3m50nntPtsYkNciMrg0x1O7KC53pxNexWj/yjwrKoGTlIni2bc8UpcnNWB7ZZos7QmYff7hKoGWYIFYLFHNDbMmwx4Ofyga0UtnCFqCqalsJ7JcKUgYSXcIoC7B3BIBbv7nVlWRYVNPmCXatclAhvfpEUEW3m5hBuWT4XyBf/6xqwW0DT7Mbe3ToBFPGcLa7FZuNADw== vinodh@DESKTOP-OE7EMPM"