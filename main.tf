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

resource "azurerm_postgresql_server" "mudkip" {
  name                    = "${var.prefix}-psqlserver"
  location                = azurerm_resource_group.mudkip.location
  resource_group_name     = azurerm_resource_group.mudkip.name
  administrator_login     = var.psqlserver_administrator_login
  sku_name                = "B_Gen5_1"
  version                 = "11"
  ssl_enforcement_enabled = true

  administrator_login_password = var.psqlserver_administrator_login_password
}

resource "azurerm_postgresql_database" "mudkip" {
  name                = "${var.prefix}-psqldb"
  charset             = "UTF8"
  collation           = "en-US"
  resource_group_name = azurerm_resource_group.mudkip.name
  server_name         = azurerm_postgresql_server.mudkip.name

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_postgresql_firewall_rule" "mudkip" {
  name                = "${var.prefix}-psqlfirewall"
  resource_group_name = azurerm_resource_group.mudkip.name
  server_name         = azurerm_postgresql_server.mudkip.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
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

    environment_variables = {
      "DATABASE_URL" = "postgres://${azurerm_postgresql_server.mudkip.administrator_login}@${azurerm_postgresql_server.mudkip.name}:${azurerm_postgresql_server.mudkip.administrator_login_password}@${azurerm_postgresql_server.mudkip.fqdn}:5432/${azurerm_postgresql_database.mudkip.name}?sslmode=require"
      "JWT_SECRET"   = var.jwt_secret
    }
  }
}
