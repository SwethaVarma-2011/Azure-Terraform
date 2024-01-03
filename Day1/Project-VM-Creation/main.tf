terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
    features {}
    subscription_id = "514be09c-bf52-461d-b114-3de1901737db"
}

# Creating a resource group
resource "azurerm_resource_group" "first-rg" {
    name = "terraform"
    location = "East US"
  }

# Creating a virtual network
resource "azurerm_virtual_network" "first-vnet" {
    name = "terraform-vnet"
    location = azurerm_resource_group.first-rg.location
    address_space = ["10.0.0.0/16"]
    resource_group_name = azurerm_resource_group.first-rg.name
}

# Creating a Subnet from Vnet
resource "azurerm_subnet" "first-subnet" {
    virtual_network_name = azurerm_virtual_network.first-vnet.name
    resource_group_name = azurerm_resource_group.first-rg.name
    name = "terraform-subnet"
    address_prefixes = ["10.0.0.0/24"]  
}

# Craeting Network Interface
resource "azurerm_network_interface" "network-ip" {
    name = "test"
    location = azurerm_resource_group.first-rg.location
    resource_group_name = azurerm_resource_group.first-rg.name

    ip_configuration {
        name = "internal"
        subnet_id = azurerm_subnet.first-subnet.id
        private_ip_address_allocation = "Dynamic"
    }
  
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "terraform-VM"
  resource_group_name = azurerm_resource_group.first-rg.name
  location            = azurerm_resource_group.first-rg.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "Swethavarma123" 
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.network-ip.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

 
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}  

