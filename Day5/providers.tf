terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  subscription_id = "514be09c-bf52-461d-b114-3de1901737db"
  features {}
}