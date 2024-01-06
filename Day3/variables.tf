variable "rg-name" {
    description = "Assigning name to the resource group"
    type = string
}

variable "rg-location" {
  description = "The location where the rg is created"
  type = string
}

variable "sa-name" {
  description = "Storage Account Name"
  type = string
}

variable "sg-tier" {
    description = "Storage Account tier type"
    type = string 
}

variable "acc-replication" {
    description = "Storage Account Replication type"
    type = string
}

variable "sg-container_name" {
  description = "Assigning name to the(creating) container in the storage account "
}
