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
  source = "./modules/tfstate"

  environment = var.environment
  location    = var.location
}

module "terraform_pipeline" {
  source = "./modules/terraform-pipeline"

  environment = var.environment
}
