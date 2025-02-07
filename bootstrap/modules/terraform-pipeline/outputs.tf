output "terraform_pipeline_credentials" {
  value = {
    client_id       = azuread_service_principal.terraform_pipeline.client_id
    client_secret   = azuread_service_principal_password.terraform_pipeline.value
    subscription_id = data.azurerm_subscription.current.subscription_id
    tenant_id       = data.azurerm_subscription.current.tenant_id
  }

  sensitive = true
}
