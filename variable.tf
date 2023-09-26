#Locals:

locals {
  resource_group_name = "wordpress-sqlserver-west"
  resource_group_name_north = "wordpress-sqlserver-north"
  resource_group_name_traffic_manager = "trafic-manager"
}

#Variable

variable "name" {
  type        = string
  default     = "wordpress"
  description = "Base name, i.e. prefix of azure resources"
}


variable "location" {
  type        = string
  description = "Azure Region for resources. Defaults to West Europe."
  default     = "West Europe"
}

variable "location-north" {
  type        = string
  description = "Azure Region for resources. Defaults to West Europe."
  default     = "North Europe"
}




# App Service

variable "sku" {
  type = string
  default = "S1"
  
}

variable "wordpress_image" {
  type        = string
  description = "Docker repository name with tag, e.g. Defaults to onazureio/wordpress:5.5"
  default     = "wordpress:6.3"
}

# Database MySQL

variable "mysql_admin_user" {
  type    = string
  default = ""
}


variable "password" {
  type        = string
  default     = ""
  description = "Mysql server password login"
}
