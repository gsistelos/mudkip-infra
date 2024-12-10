terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.13.0"
    }
  }

  required_version = "1.10.1"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "slim" {
  name     = "slim"
  location = "Brazil South"
}
