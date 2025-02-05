output "terraform_pipeline_credentials" {
  value     = module.terraform_pipeline.terraform_pipeline_credentials
  sensitive = true
}
