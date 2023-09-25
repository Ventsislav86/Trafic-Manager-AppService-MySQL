terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.72.0"
    }
  }
}


provider "azurerm" {
  subscription_id = "7f9039ab-1882-420d-9790-518f14352619"
  tenant_id       = "93f33571-550f-43cf-b09f-cd331338d086"
  client_id       = "dd0e81bd-a4a1-4aba-a532-6d8c4c9beccf"
  client_secret   = "VhJ8Q~nCQ8z7kaXdDvNVVWb1hdxJHEljdCyGfb.K"
  features {
    resource_group {
    }
  }
}
