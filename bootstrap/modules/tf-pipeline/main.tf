data "azurerm_subscription" "current" {}

# Create a service principal for Terraform pipeline
resource "azuread_application" "tf_pipeline" {
  display_name = "tf-${var.environment}-pipeline-mudkip-app"
}

resource "azuread_service_principal" "tf_pipeline" {
  client_id = azuread_application.tf_pipeline.client_id
}

resource "azuread_service_principal_password" "tf_pipeline" {
  service_principal_id = azuread_service_principal.tf_pipeline.id
}

# Give Owner permissions for managing resources
resource "azurerm_role_assignment" "tf_pipeline" {
  scope                = "/subscriptions/${data.azurerm_subscription.current.subscription_id}"
  role_definition_name = "Owner"
  principal_id         = azuread_service_principal.tf_pipeline.object_id
}

# Give Application Administrator permissions for managing permissions
resource "azuread_directory_role_assignment" "tf_pipeline_app_admin" {
  role_id             = "9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3" # Application Administrator role ID
  principal_object_id = azuread_service_principal.tf_pipeline.object_id
}
