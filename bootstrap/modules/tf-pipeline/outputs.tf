output "tf_pipeline_credentials" {
  value = {
    ARM_CLIENT_ID       = azuread_service_principal.tf_pipeline.client_id
    ARM_CLIENT_SECRET   = azuread_service_principal_password.tf_pipeline.value
    ARM_SUBSCRIPTION_ID = data.azurerm_subscription.current.subscription_id
    ARM_TENANT_ID       = data.azurerm_subscription.current.tenant_id
  }

  sensitive = true
}
