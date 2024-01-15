terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  subscription_id = ""
  features {}
}

resource "azurerm_resource_group" "existing_rg" {
  name = "myrg"
  location = "East US"
}


# terraform plan --- Shows you that 1 resource needs to be added
# Now do terraform import -- terraform import azurerm_resource_group.existing_rg(<provider_resourcetype.reourcename) <ResourceID>
# resourceID is in the properties tab of the resource in portal
# Now hit terraform plan -- It shows no Chnages and Infrastructure matches the configuration.