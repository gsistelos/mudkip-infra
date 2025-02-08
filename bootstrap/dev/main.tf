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
  source = "../modules/tfstate"

  environment = "dev"
  location    = "East US"
}

module "tf_pipeline" {
  source = "../modules/tf-pipeline"

  environment = "dev"
}

output "tf_pipeline_credentials" {
  value     = module.tf_pipeline.tf_pipeline_credentials
  sensitive = true
}
