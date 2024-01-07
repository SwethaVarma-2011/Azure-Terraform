resource "azurerm_resource_group" "myrg" {
  name = var.rg-name
  location = var.rg-location
}

resource "azurerm_virtual_network" "vnet" {
  name = var.vnet-name
  resource_group_name = azurerm_resource_group.myrg.name
  location = azurerm_resource_group.myrg.location
  address_space = [var.VNet-address-space]
}

resource "azurerm_subnet" "subnet" {
 name = var.subnet-name
 virtual_network_name = azurerm_virtual_network.vnet.name
 resource_group_name = azurerm_resource_group.myrg.name
 address_prefixes = var.subnet-prefix
}

resource "azurerm_network_security_group" "nsg" {
  name = var.nsg-name
  resource_group_name = azurerm_resource_group.myrg.name
  location = azurerm_resource_group.myrg.location

  security_rule {
    name                       = "Allow-Http"
    priority                   = 100
    direction                  = var.sg-rule-direction
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  
  /*security_rule {
    name                       = "Allow-ssh"
    priority                   = 200
    direction                  = var.sg-rule-direction
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }*/
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_public_ip" "public-ip" {
    resource_group_name = azurerm_resource_group.myrg.name
    name = var.public-ip
    location = azurerm_resource_group.myrg.location
    allocation_method = var.public-ip-method
  
}

resource "azurerm_network_interface" "nic" {
  name = var.nic-name
  resource_group_name = azurerm_resource_group.myrg.name
  location = azurerm_resource_group.myrg.location
  ip_configuration {
    name = var.nic-ip-conf-name
    subnet_id = azurerm_subnet.subnet.id
    private_ip_address_allocation = var.nic-private-ip
    public_ip_address_id = azurerm_public_ip.public-ip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name = var.vm-name
  resource_group_name = azurerm_resource_group.myrg.name
  location = azurerm_resource_group.myrg.location
  network_interface_ids = [azurerm_network_interface.nic.id]
  size = var.vm-size
  admin_username = var.vm-user
  admin_password = var.vm-password
  disable_password_authentication = "false"

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

    
  provisioner "file" {

    source = "C:/Users/Swetha varma/Documents/Azure-Terraform/Day5/app.py"
    destination = "/home/swetha/app.py"

    connection {
    type        = "ssh"
    user        = "swetha"  # Replace with the appropriate username for your EC2 instance
    password    = "Swethavarma123"  
    host        = self.public_ip_address
    timeout     = "2m"
    } 
   
 }

  provisioner "remote-exec" {

    connection {
    type        = "ssh"
    user        = "swetha"  # Replace with the appropriate username for your EC2 instance
    password    = "Swethavarma123"  
    host        = self.public_ip_address
    timeout     = "2m"
    } 

    inline = [ 
        "echo 'Hello, Welcome to remote instance'",
        "sudo apt update -y",
        "sudo apt-get install -y python3-pip",
        "cd /home/swetha",
        "sudo pip3 install flask",
        "sudo python3 app.py"
    ]
    
  }

}






  