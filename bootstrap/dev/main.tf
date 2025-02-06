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

module "key_vault" {
  source = "../modules/key-vault"

  environment                      = "dev"
  location                         = "East US"
  terraform_pipeline_object_id     = module.terraform_pipeline.terraform_pipeline_object_id
  terraform_pipeline_client_secret = module.terraform_pipeline.terraform_pipeline_client_secret
}
