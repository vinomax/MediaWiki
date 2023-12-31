terraform {
  backend "azurerm" {
    subscription_id      = "3c619550-14a0-4006-a7a3-5f0401873fca"
    resource_group_name  = "ThoughtWorks"
    storage_account_name = "thoughtworksmedia" 
    container_name       = "terraformstate"
    key                  = "terraform.tfstate" 
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}  
}
provider "azurerm" {
  alias                      = "thoughtworks"
  subscription_id            = var.subscription_id
  skip_provider_registration = true
  features {}
}
