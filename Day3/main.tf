resource "azurerm_resource_group" "rg" {
    name = var.rg-name
    location = var.rg-location 
}

resource "azurerm_storage_account" "sg" {
    name = var.sa-name
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    account_tier = var.sg-tier
    account_replication_type = var.acc-replication
}

resource "azurerm_storage_container" "sgc" {
    name = var.sg-container_name
    storage_account_name = azurerm_storage_account.sg.name
}