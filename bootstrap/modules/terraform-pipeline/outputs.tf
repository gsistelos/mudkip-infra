output "terraform_pipeline_object_id" {
  value = azuread_service_principal.terraform_pipeline.object_id
}

output "terraform_pipeline_client_secret" {
  value     = azuread_service_principal_password.terraform_pipeline.value
  sensitive = true
}
