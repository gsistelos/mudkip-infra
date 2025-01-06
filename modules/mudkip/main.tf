data "azurerm_subscription" "current" {}

# Create a GitHub Actions service principal for Terraform workflow
resource "azuread_application" "github_actions_terraform" {
  display_name = "github-actions-${var.environment}-mudkip-terraform"
}

resource "azuread_service_principal" "github_actions_terraform" {
  client_id = azuread_application.github_actions_terraform.client_id
}

resource "azuread_service_principal_password" "github_actions_terraform" {
  service_principal_id = azuread_service_principal.github_actions_terraform.id
}

# Give GitHub Actions permissions to the subscription
resource "azurerm_role_assignment" "github_actions_terraform" {
  scope                = "/subscriptions/${data.azurerm_subscription.current.subscription_id}"
  role_definition_name = "Owner"
  principal_id         = azuread_service_principal.github_actions_terraform.object_id
}
