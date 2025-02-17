terraform {
  # Backend configuration determines where Terraform stores its state files.
  # State files are used to track the current state of your infrastructure.
  # Using a backend instead of local state is essential for team collaboration.
  # Bootstrap the backend in ../bootstrap
  backend "azurerm" {
    resource_group_name  = "tfstate-prod-mudkip-rg"
    storage_account_name = "tfstateprodmudkip"
    container_name       = "tfstate"
    key                  = "prod/terraform.tfstate"
  }
}

module "mudkip" {
  source = "../modules/mudkip"

  environment = "prod"
  location    = "East US"
}
