terraform {
  required_version = "1.10.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.17.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.1.0"
    }
  }

  # Backend configuration determines where Terraform stores its state files.
  # State files are used to track the current state of your infrastructure.
  # Using a backend instead of local state is essential for team collaboration.
  # Bootstrap the backend in ../bootstrap
  backend "azurerm" {
    resource_group_name  = "tfstate-dev-mudkip-rg"
    storage_account_name = "tfstatedevmudkip"
    container_name       = "tfstate"
    key                  = "dev/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
