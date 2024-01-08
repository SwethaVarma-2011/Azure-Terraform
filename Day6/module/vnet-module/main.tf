provider "azurerm" {
  features {}
}

resource "azurerm_virtual_network" "vnet" {
  name = var.vnet-name
  resource_group_name = var.rg-name
  location = var.vnet-location
  address_space = var.vnet-ip
}