variable "environment" {
  description = "Environment where resources will be created (dev, prod)"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created (Brazil South, East US)"
  type        = string
  default     = "East US"
}
