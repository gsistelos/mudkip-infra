output "github_actions_terraform_credentials" {
  value     = module.github_actions_terraform.github_actions_terraform_credentials
  sensitive = true
}
