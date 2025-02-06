data "azurerm_client_config" "current" {}

# Resource group for the Key Vault
resource "azurerm_resource_group" "key_vault" {
  name     = "key-vault-${var.environment}-mudkip-rg"
  location = var.location
}

resource "azurerm_key_vault" "key_vault" {
  name                = "keyvault${var.environment}mudkip" # Global unique name
  resource_group_name = azurerm_resource_group.key_vault.name
  location            = azurerm_resource_group.key_vault.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
}

resource "azurerm_key_vault_access_policy" "key_vault" {
  key_vault_id = azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get", "List", "Create", "Delete", "Recover",
  ]

  secret_permissions = [
    "Get", "List", "Set", "Delete", "Recover",
  ]
}

resource "azurerm_key_vault_access_policy" "terraform_pipeline" {
  key_vault_id = azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.terraform_pipeline_object_id

  secret_permissions = [
    "Get", "List",
  ]
}

resource "azurerm_key_vault_secret" "terraform_pipeline_client_secret" {
  name         = "terraform-pipeline-client-secret"
  value        = var.terraform_pipeline_client_secret
  key_vault_id = azurerm_key_vault.key_vault.id
}
