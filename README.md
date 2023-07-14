# **MEDIAWIKI configuration using Terraform and Ansible.**
------
### [MediaWiki Application](https://www.mediawiki.org/wiki/Manual:Running_MediaWiki_on_Red_Hat_Linux).

### **Pre Requisites :**

1. Azure infrastructure with subscription is required for this project. Create one if you dont have a subscription. https://azure.microsoft.com/
2. The local machine used to run project should have terraform, azure CLI installed. 
   Follow links for installations,
   - Terraform - https://developer.hashicorp.com/terraform/downloads
   - Azure CLI - https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli
3. Terraform uses *terraform.tfvars* file in root location as predefined variables, these variables can be changed as per your need.
4. Create blob storage by following below azure CLI commands to store terraform state file,
  az login
  (Chrome browser will popup to authenticate in azure using your subscription.)
  az group create --name ThoughtWorks --location eastus
  az storage account create --resource-group ThoughtWorks --name thoughtworksmedia --sku Standard_LRS --encryption-services blob
  az storage container create --name terraformstate --account-name thoughtworksmedia
  If you face error in above command, navigate to microsoft portal and create a new container in storage account. https://learn.microsoft.com/en-us/azure/storage/blobs/blob-containers-portal
5. Make sure to update *terraform.tfvars* if above variables (ThoughtWorks, thoughtworksmedia, terraformstate) are changed during container creation.
6. Update your subscription_id in *providers.tf* and terraform.tfvars* files.

### **Project Structure :**

1. ansible folder has below files,\
   LocalSettings.php.j2 - It is used as template and values will be updated during mediawiki package deployment in ansible playbook.\
   playbook.yml - It defines detailed config setup for LAMP stack and mediawiki.\
   vars.yml - It will have all database and config related settings\
   setDB.sh - This script is used to set initial db, users and password. It enables mediawiki to access db.
2. modules folder has below subfolders,\
   keyvault - This is not currently implemented, for future it will be used for updating project secrets.\
   network - This module will create VNet and subnets for the project.\
   virtual_machine - This module will create vm in azure cloud.
3. Root files and it usages,\
   main.tf - Acts as the main entry for terraform script.\
   outputs.tf - will give public ip after terraform execution to access website. \
   providers.tf - state file and other terraform configurations.\
   terraform.tfvars - use to pass values to terraform during runtime.\
   variables.tf - variables for main.tf file.

### **Project Execution :**
Execute below terraform commands in project location
``` 
  terraform init
  terraform plan
  terraform apply --auto-approve

```
### **Project Walkthrough :**
Once the above terrafrom commands are executed, private_key.pem file will be generated with contents which has private key to access linux vm created in Azure portal.\
Use public ip from terraform output to connect to instance using private_key.pem file.\
In current project i have used Centos 8 OS, similar settings can be updated in terraform.tfvars file.\

Note:- The porject execution is success, but i am seeing some issue in latest mediawiki while accessing DB.

### **Future Project Enhancement**

1. private_key will be stored in key vault.
2. Terraform workspace will be implemented to ease environment access.
3. Scripts and configurations will be moved to seperate repo.
4. Currently scripts are copied to host for execution, ansible host will be registered and secrets will be encrypted through ansible vault.

