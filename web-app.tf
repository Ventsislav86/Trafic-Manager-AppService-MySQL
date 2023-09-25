# App Service
# -----------

resource "azurerm_service_plan" "plan" {
  name                = "plan-west-${var.name}"
  location            = var.location
  resource_group_name = local.resource_group_name  
  os_type             = "Linux"
  sku_name            = var.sku
  worker_count        = 1
  depends_on          = [azurerm_resource_group.wordpress]

}


resource "azurerm_linux_web_app" "app" {
  name                    = "app-west-${var.name}"
  location                = var.location
  resource_group_name     = local.resource_group_name
  service_plan_id         = azurerm_service_plan.plan.id
  https_only              = true
  client_affinity_enabled = false

  # N.B. because this is a key value pair, secrets here end up in logs (not good for CI/CD pipelines)
  app_settings = {    
    "WORDPRESS_DB_HOST"                     = azurerm_mysql_flexible_server.wordpress.fqdn
    "WORDPRESS_DB_NAME"                     = azurerm_mysql_flexible_database.wordpress.name
    "WORDPRESS_DB_USER"                     = var.mysql_admin_user
    "WORDPRESS_DB_PASSWORD"                 = var.password
    "WORDPRESS_DB_SSL"                      = true
    "WORDPRESS_DB_PORT"                    = "3306"
    "DOCKER_ENABLE_CI"                       = "true"    
    "MICROSOFT_AZURE_CONTAINER"              = "wordpress"      
  }

  site_config {
    always_on = true
    application_stack {
      docker_registry_url = "https://index.docker.io"
      docker_image_name   = var.wordpress_image
    }

  }
  depends_on = [azurerm_service_plan.plan,
    azurerm_resource_group.wordpress,
    azurerm_mysql_flexible_server.wordpress,
    azurerm_mysql_flexible_database.wordpress]
}
