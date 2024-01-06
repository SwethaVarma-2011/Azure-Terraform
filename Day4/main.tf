terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "514be09c-bf52-461d-b114-3de1901737db"
}

resource "azurerm_resource_group" "rg" {
  name = var.rg-name
  location = var.rg-location
}

resource "azurerm_virtual_network" "Vnet" {
  resource_group_name = azurerm_resource_group.rg.name
  name = var.vnet-name
  location = azurerm_resource_group.rg.location
  address_space = [var.vnet-address]
}

/*resource "azurerm_subnet" "Subnet" {
  name = var.subnet-name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes = var.subnet-ips
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_public_ip" "public-ip" {
  name = ""
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  allocation_method = "Dynamic"
}

resource "azurerm_network_interface" "nic" {
  name = ""
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.loc
  ip_configuration {
    subnet_id = azurerm_subnet.Subnet.id
    name = ""
    private_ip_address_allocation = ""
    public_ip_address_id = azurerm_public_ip.public-ip.id
  }
  
}*/