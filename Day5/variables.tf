variable "rg-name" {
    description = "Assigning resource group name"
    type = string
}

variable "rg-location" {
    description = "Location of the Resource Group"
    type = string
}

variable "vnet-name" {
    description = "Name of the Virtual Machine"
    type = string
}

variable "VNet-address-space" {
  description = "Assiging the Ip address of the vnet"
}

variable "subnet-name" {
    description = "Name of the subnet"
    type = string
}

variable "subnet-prefix" {
    description = "Address of the subnet within the Vnet range"
}

variable "nsg-name" {
  description = "Creating network security group and assigning name to it"
  type = string
}

variable "sg-rule-direction" {
  description = "Assigning direction of the security group rule Inbound/Outbound"
  default = "Inbound"
}

variable "public-ip" {
    description = "Name of the Ip address that is used to create a VM with Public Ip address"
}

variable "public-ip-method" {
    description = "Defining the ip address allocation type as Dynammic"
    type = string  
}

variable "nic-name" {
    description = "creating the name for network interface for the vm"
}

variable "nic-ip-conf-name" {
    description = "Assigning name for the ip config for the nic"
    type = string
}

variable "nic-private-ip" {
    description = "Allocating the Private-ip of the vm in Nic as Dynamic"
    type = string  
}

variable "vm-name" {
    description = "Assigning name to the Virtual Machine"
    type = string  
}

variable "vm-size" {
  description = "Assigning the size of the vm"
  type = string
}

variable "vm-user" {
  description = "Creating user name of the Vm"
  type  = string
}

variable "vm-password" {
  description = "Assigning password to the vm"
  type = string
}