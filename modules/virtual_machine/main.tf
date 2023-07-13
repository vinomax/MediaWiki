resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = var.pip_allocation
}

resource "azurerm_network_interface" "vm_nic" {
  name                = var.vm_nic
  resource_group_name = var.rg_name
  location            = var.location

  ip_configuration {
    name                          = var.ip_configuration
    subnet_id                     = var.vm_subnetid
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_network_security_group" "vm_nsg" {
  name                = "vm_nsg"
  location            = var.location
  resource_group_name = var.rg_name
  security_rule {
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = "tls"
    priority                   = 100
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "443"
    destination_address_prefix = azurerm_network_interface.vm_nic.private_ip_address
  }
  security_rule {
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = "http"
    priority                   = 120
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "80"
    destination_address_prefix = azurerm_network_interface.vm_nic.private_ip_address
  }
  security_rule {
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = "ssh"
    priority                   = 1001
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "22"
    destination_address_prefix = azurerm_network_interface.vm_nic.private_ip_address
  }
}

resource "azurerm_network_interface_security_group_association" "nw_connect" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}

resource "azurerm_linux_virtual_machine" "linuxvm" {
  name                            = var.vm_name
  resource_group_name             = var.rg_name
  location                        = var.location
  size                            = var.vm_size
  network_interface_ids           = [azurerm_network_interface.vm_nic.id]
  disable_password_authentication = true
  admin_username                  = var.vm_username
  
  source_image_reference {
    publisher = var.vm_image_publisher
    offer     = var.vm_image_offer
    sku       = var.vm_image_sku
    version   = var.vm_image_version
  }
  os_disk {
    storage_account_type = var.vm_os_disk_strg_type
    caching              = var.vm_os_disk_caching
  }
  
  admin_ssh_key {
    username   = var.vm_username
    # public_key = tls_private_key.example_ssh.public_key_openssh
    public_key = var.vm_public_key
  }  
  provisioner "remote-exec" {   
    connection {
      host        = azurerm_linux_virtual_machine.linuxvm.public_ip_address
      type        = "ssh"
      user        = var.vm_username
      private_key = file("./private_key.pem")
      timeout     = "2m"
    }
    inline = [
      "sudo yum update -y",
      "sudo yum install -y python3-pip",
      "sudo pip3 install --upgrade pip",
      "pip3 install 'ansible==2.9.17'",
      "echo 'Ansible installed !!'"]
  }
}

