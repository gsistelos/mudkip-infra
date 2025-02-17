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
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "mudkip" {
  name     = "main-${var.environment}-mudkip-rg"
  location = var.location
}

resource "azurerm_container_registry" "mudkip" {
  name                = "registry${var.environment}mudkip" # Global unique name
  resource_group_name = azurerm_resource_group.mudkip.name
  location            = azurerm_resource_group.mudkip.location
  sku                 = "Basic"

  admin_enabled = true
}

# TODO: See terraform_data `https://developer.hashicorp.com/terraform/language/resources/terraform-data`
resource "null_resource" "build_and_push_image" {
  provisioner "local-exec" {
    command = <<EOF
      docker build -t ${azurerm_container_registry.mudkip.login_server}/mudkip:latest .
      docker login ${azurerm_container_registry.mudkip.login_server} -u ${azurerm_container_registry.mudkip.admin_username} -p ${azurerm_container_registry.mudkip.admin_password}
      docker push ${azurerm_container_registry.mudkip.login_server}/mudkip:latest
    EOF

    working_dir = "mudkip"
  }
}

resource "azurerm_container_group" "mudkip" {
  name                = "continst-${var.environment}-mudkip"
  location            = azurerm_resource_group.mudkip.location
  resource_group_name = azurerm_resource_group.mudkip.name
  os_type             = "Linux"

  ip_address_type = "Public"

  image_registry_credential {
    server   = azurerm_container_registry.mudkip.login_server
    username = azurerm_container_registry.mudkip.admin_username
    password = azurerm_container_registry.mudkip.admin_password
  }

  container {
    name   = "mudkip"
    image  = "${azurerm_container_registry.mudkip.login_server}/mudkip:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port = 8080
    }
  }

  depends_on = [null_resource.build_and_push_image]
}
