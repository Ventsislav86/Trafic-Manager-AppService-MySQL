# Resource Group
# --------------

resource "azurerm_resource_group" "wordpress" {
  name     = local.resource_group_name
  location = var.location 
}

resource "azurerm_resource_group" "wordpress-north" {
  name     = local.resource_group_name_north
  location = var.location-north
}

resource "azurerm_resource_group" "trafic-manager" {
  name     = local.resource_group_name_traffic_manager
  location = var.location
}