terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.13.0"
    }
  }

  required_version = "1.10.1"
}

variable "psqlserver_administrator_login" {
  type        = string
  description = "The administrator login for the PostgreSQL Server."
}

variable "psqlserver_administrator_login_password" {
  type        = string
  description = "The password associated with the administrator login for the PostgreSQL Server."
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "mudkip_rg" {
  name     = "mudkip-rg"
  location = "Brazil South"
}

resource "azurerm_postgresql_server" "mudkip_psqlserver" {
  name     = "mudkip-psqlserver"
  location = azurerm_resource_group.mudkip_rg.location

  resource_group_name = azurerm_resource_group.mudkip_rg.name

  administrator_login          = var.psqlserver_administrator_login
  administrator_login_password = var.psqlserver_administrator_login_password

  sku_name = "B_Gen5_1"
  version  = "11"

  ssl_enforcement_enabled = true
}

resource "azurerm_postgresql_database" "mudkip_psqldb" {
  name      = "mudkip-psqldb"
  charset   = "UTF8"
  collation = "en-US"

  resource_group_name = azurerm_resource_group.mudkip_rg.name
  server_name         = azurerm_postgresql_server.mudkip_psqlserver.name

  lifecycle {
    prevent_destroy = true
  }
}

output "psqlserver_fqdn" {
  value = azurerm_postgresql_server.mudkip_psqlserver.fqdn
}
