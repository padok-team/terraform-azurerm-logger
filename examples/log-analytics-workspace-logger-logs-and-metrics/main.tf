# This example deploys a keyvault and configure it to send the keyvault logs and metrics to a log analytics workspace.
terraform {
  required_version = ">= 0.13.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
  }
}
provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  features {}
}

resource "azurerm_resource_group" "this" {
  name     = "my-example-rg"
  location = "westeurope"
}

resource "random_pet" "random" {}

data "azurerm_client_config" "this" {}

module "key_vault" {
  source = "git@github.com:padok-team/terraform-azurerm-keyvault.git?ref=v0.4.0"

  name           = random_pet.random.id # KeyVault names are globally unique
  resource_group = azurerm_resource_group.this
  tenant_id      = data.azurerm_client_config.this.tenant_id
  sku_name       = "standard"

  depends_on = [
    azurerm_resource_group.this
  ]
}

module "logger" {
  source = "../.."

  resource_group = azurerm_resource_group.this

  name                 = "test"
  create_new_workspace = true

  # I want to monitor both logs and metrics for my keyvault
  resources_to_logs    = [module.key_vault.this.id]
  resources_to_metrics = [module.key_vault.this.id]
}
