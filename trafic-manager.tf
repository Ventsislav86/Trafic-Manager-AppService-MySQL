resource "azurerm_traffic_manager_profile" "trafic-manager" {
  name                   = "trafic-manager"
  resource_group_name    = local.resource_group_name_traffic_manager
  traffic_routing_method = "Priority"

  dns_config {
    relative_name = "my-wordpress"
    ttl           = 100
  }

  monitor_config {
    protocol                     = "HTTP"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }
  depends_on = [azurerm_resource_group.trafic-manager]
}


resource "azurerm_traffic_manager_azure_endpoint" "primary_endpoint" {
  name               = "apps-west"
  profile_id         = azurerm_traffic_manager_profile.trafic-manager.id
  weight             = 100
  priority           = 1
  target_resource_id = azurerm_linux_web_app.app.id
  depends_on = [ azurerm_traffic_manager_profile.trafic-manager, azurerm_linux_web_app.app ]
}


resource "azurerm_traffic_manager_azure_endpoint" "secondary_endpoint" {
  name               = "apps-north"
  profile_id         = azurerm_traffic_manager_profile.trafic-manager.id
  weight             = 100
  priority           = 2
  target_resource_id = azurerm_linux_web_app.app-north.id
  depends_on = [ azurerm_traffic_manager_profile.trafic-manager, azurerm_linux_web_app.app-north]
}