# mudkip-infra

A project to learn GitHub Actions CI/CD pipeline with Terraform.

# Getting Started

1. **Dependencies**
    * [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli#install-terraform)
    * [Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

2. **Environment Setup**
    * Login to Azure with `az login`
    * Set environment variables
        * `export ARM_SUBSCRIPTION_ID="$(az account show --query id -o tsv)"`

You can now run `terraform init` and start building your infrastructure.
