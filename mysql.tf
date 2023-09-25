resource "azurerm_mysql_flexible_server" "wordpress" {
  name                   = "sqlserver-varbanov-${var.name}"
  location               = var.location
  resource_group_name    = local.resource_group_name
  administrator_login    = var.mysql_admin_user
  administrator_password = var.password  
  sku_name               = "GP_Standard_D2ds_v4"    
  zone                   = "1" 
  create_mode            = "Replica"
  high_availability {
    mode                      = "ZoneRedundant"
    standby_availability_zone = "2"
  }

  storage {
    auto_grow_enabled = true
  }
  depends_on = [azurerm_resource_group.wordpress     
  ]
  
}

resource "azurerm_mysql_flexible_database" "wordpress" {
  name                = "${var.name}"
  resource_group_name = local.resource_group_name
  server_name         = azurerm_mysql_flexible_server.wordpress.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
  depends_on          = [azurerm_resource_group.wordpress, azurerm_mysql_flexible_server.wordpress]
}


resource "azurerm_mysql_flexible_server_configuration" "parametar" {
  name                = "require_secure_transport"
  resource_group_name = local.resource_group_name
  server_name         = azurerm_mysql_flexible_server.wordpress.name
  value               = "OFF"
  depends_on = [azurerm_mysql_flexible_server.wordpress]
}

resource "azurerm_mysql_flexible_server_firewall_rule" "azure" {
  name                = "public-internet"
  resource_group_name = local.resource_group_name
  server_name         = azurerm_mysql_flexible_server.wordpress.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
  depends_on          = [azurerm_resource_group.wordpress, azurerm_mysql_flexible_server.wordpress]
}