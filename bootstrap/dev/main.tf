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

module "terraform_pipeline" {
  source = "../modules/terraform-pipeline"

  environment = "dev"
}

output "terraform_pipeline_credentials" {
  value     = module.terraform_pipeline.terraform_pipeline_credentials
  sensitive = true
}
