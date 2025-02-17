terraform {
  required_version = "1.10.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.17.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "tfstate" {
  source = "../tfstate"

  environment = var.environment
  location    = var.location
}

module "tf_pipeline" {
  source = "../tf-pipeline"

  environment = var.environment
}
