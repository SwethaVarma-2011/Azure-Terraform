variable "rg-name" {
    description = "Assigning name to the resource group"    
    type = string
}

variable "rg-location" {
  description = "Location where the rg needs to be created"
  type = string
}

variable "vnet-name" {
    description = "Assigning name to the vnet"
    type = string    
}

variable "vnet-address" {
  description = "Assigning Ip address to the Vnet"
}

/*variable "subnet-name" {
  description = "Name of the subnet"
}

variable "subnet-ips" {
  description = "Assigining ip address to the subnets"
} */