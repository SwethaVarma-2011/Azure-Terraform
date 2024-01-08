/*variable "rgname" {
  description = "Creating resource group and assigning name to it"
}*/

variable "rglocation" {
  description = "Assigning location to the resource group"
}

variable "vnet-ip" {
  description = "Assigning address range cidr block to Vnet"
}

variable "vnet-name" {
  description = "Assigning name to the vnet and creating subnet under vnet"
}

variable "sub-name" {
  description = "assigning name to the subnet"
}

variable "sub-ip" {
    description = "Assigning ip address to the subnet"
  
}