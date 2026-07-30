terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.80.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatejylu2026"
    container_name       = "statecon"
    key                  = "terraform01.devstate"

  }
}
provider "azurerm" {
  features {}
}
