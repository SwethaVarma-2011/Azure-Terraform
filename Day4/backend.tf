terraform {
  backend "azurerm" {
    resource_group_name  = "moduleRG"
    storage_account_name = "swethavarma43254"
    container_name       = "swetha"
    key                  = "swetha.terraform.tfstate"
  }
}