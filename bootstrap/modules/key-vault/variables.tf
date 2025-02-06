variable "environment" {
  description = "Environment where resources will be created (dev, prod)"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created (Brazil South, East US)"
  type        = string
}

variable "terraform_pipeline_object_id" {
  description = "Object ID for the Terraform pipeline SP"
  type        = string
}

variable "terraform_pipeline_client_secret" {
  description = "Client secret for the Terraform pipeline SP"
  type        = string
}
