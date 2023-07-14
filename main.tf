############# 1. Create keyvault #############
# module "key_vault" {
#   source            = "./modules/keyvault"
#   keyvault_Name     = var.kv_dev_Name
#   rg_name           = var.rg_name
# }

############# 1. VNET & SUBNET Deployment Code #############
module "virtual_network" {
  source             = "./modules/network"
  vnet_Name          = var.vnet_Name
  rg_name            = var.rg_name
  location           = var.location
  vnet_Address       = var.vnet_Address
  subnet_NameList    = var.subnet_NameList
  subnet_AddressList = var.subnet_AddressList
}

######### 3. Azure Linux Virtual Machine deployment #########
module "linux_vm" {
  depends_on           = [module.virtual_network.subnet]
  source               = "./modules/virtual_machine"
  public_ip            = var.public_ip
  rg_name              = var.rg_name
  location             = var.location
  pip_allocation       = var.pip_allocation
  vm_nic               = var.vm_nic
  ip_configuration     = var.ip_configuration
  vm_name              = var.vm_name
  vm_size              = var.vm_size
  vm_username          = var.vm_username
  vm_image_publisher   = var.vm_image_publisher
  vm_image_offer       = var.vm_image_offer
  vm_image_sku         = var.vm_image_sku
  vm_image_version     = var.vm_image_version
  vm_os_disk_strg_type = var.vm_os_disk_strg_type
  vm_os_disk_caching   = var.vm_os_disk_caching
  vm_public_key        = local.tls_public_key_contents
  vm_subnetid          = module.virtual_network.subnet_Id[0]
}

resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "idrsa" {
  filename = "./private_key.pem"
  file_permission = "0600"
  content  = <<-EOT
    ${tls_private_key.example_ssh.private_key_pem}
  EOT
}
locals {
  tls_public_key_contents = tls_private_key.example_ssh.public_key_openssh
}
resource "null_resource" "config_execution" {
  triggers = {
    public_ip = module.linux_vm.vm_instance_pip
  }
  connection {
      host        = module.linux_vm.vm_instance_pip
      type        = "ssh"
      user        = var.vm_username
      private_key = tls_private_key.example_ssh.private_key_pem
      timeout     = "20m"
    }
  provisioner "file" {
    source  = "ansible/playbook.yml"  
    destination  = "/tmp/playbook.yml"  # will copy to remote VM
  } 
  provisioner "file" {
    source  = "ansible/vars.yml"  
    destination  = "/tmp/vars.yml"  # will copy to remote VM 
  }
  provisioner "file" {
    source  = "ansible/LocalSettings.php.j2"  
    destination  = "/tmp/LocalSettings.php.j2"  # will copy to remote VM
  }
  provisioner "file" {
    source  = "ansible/setDB.sh"  
    destination  = "/tmp/setDB.sh"  # will copy to remote VM
  }
  provisioner "remote-exec" {       
    inline = [      
      "chmod +x /tmp/setDB.sh",
      "chmod +x /tmp/LocalSettings.php",
      "chmod +x /tmp/playbook.yml",
      "chmod +x /tmp/vars.yml",
      "sudo dnf upgrade -y",
      "sudo dnf update -y",
      "sudo dnf install -y python3-pip",
      "sudo pip3 install --upgrade pip",
      "sudo pip3 install 'ansible==2.9.17'",
      "echo 'Ansible installed!!'" ]
  }  
  provisioner "remote-exec" {       
    inline = [
      "ansible-playbook -i localhost /tmp/playbook.yml" ]
  }  
}
