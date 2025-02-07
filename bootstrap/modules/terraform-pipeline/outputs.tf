output "terraform_pipeline_credentials" {
  value = {
    clientId       = azuread_service_principal.terraform_pipeline.client_id
    clientSecret   = azuread_service_principal_password.terraform_pipeline.value
    subscriptionId = data.azurerm_subscription.current.subscription_id
    tenantId       = data.azurerm_subscription.current.tenant_id
  }

  sensitive = true
}
