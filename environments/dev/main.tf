terraform {
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

module "mudkip" {
  source = "../modules/mudkip"

  environment = "dev"
  location    = "East US"
}
