terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.13.0"
    }
  }

  required_version = "1.10.2"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "mudkip" {
  name     = "${var.prefix}-resources"
  location = "Brazil South"
}

resource "azurerm_container_registry" "mudkip" {
  name                = "${var.prefix}registry"
  resource_group_name = azurerm_resource_group.mudkip.name
  location            = azurerm_resource_group.mudkip.location
  sku                 = "Basic"

  admin_enabled = true
}

resource "azurerm_container_group" "mudkip" {
  name                = "${var.prefix}-continst"
  location            = azurerm_resource_group.mudkip.location
  resource_group_name = azurerm_resource_group.mudkip.name
  os_type             = "Linux"

  ip_address_type = "Public"

  image_registry_credential {
    server   = azurerm_container_registry.mudkip.login_server
    username = azurerm_container_registry.mudkip.admin_username
    password = azurerm_container_registry.mudkip.admin_password
  }

  container {
    name   = "mudkip"
    image  = "${azurerm_container_registry.mudkip.login_server}/mudkip:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port = 8080
    }
  }
}
