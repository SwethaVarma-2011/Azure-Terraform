# Creating resource group
resource "azurerm_resource_group" "rg" {
  name = var.rg-name
  location = var.rg-location
}

# Creating Vnet
resource "azurerm_virtual_network" "VNet" {
    name = var.vm-name
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    address_space = [var.VNet-address_space]
}

# Creating Subnet
resource "azurerm_subnet" "subnet" {
  name = var.subnet-name
  virtual_network_name = azurerm_virtual_network.VNet.name
  resource_group_name = azurerm_resource_group.rg.name
  address_prefixes = var.subnet-prefix
}

# Creating public-ip address for VM
resource "azurerm_public_ip" "public-ip" {
    name = var.public-ip
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    allocation_method = var.public-ip-method
}

# Creating Network nterface for VM
resource "azurerm_network_interface" "nic" {
  name = var.nic
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name = var.nic-ip-conf-name
    subnet_id = azurerm_subnet.subnet.id
    private_ip_address_allocation = var.nic-private-ip
    public_ip_address_id = azurerm_public_ip.public-ip.id
  }

}

# Creating a Vm
resource "azurerm_linux_virtual_machine" "vm" {
    name = var.vm
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    size = var.vm-size
    network_interface_ids = [azurerm_network_interface.nic.id]
    admin_username = var.vm-user
    admin_password = var.vm-password
    disable_password_authentication = false

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
