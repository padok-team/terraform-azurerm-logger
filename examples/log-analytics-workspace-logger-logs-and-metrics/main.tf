# This example deploys a keyvault and configure it to send the keyvault logs and metrics to a log analytics workspace.
terraform {
  required_version = ">= 0.13.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.82.0"
    }
  }
}
provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  features {}
}

resource "azurerm_resource_group" "resource_group" {
  name     = "my-example-rg"
  location = "westeurope"

  tags = {
    terraform = "true",
    padok     = "library"
  }
}

module "key_vault" {
  source = "git@github.com:padok-team/terraform-azurerm-keyvault.git?ref=v0.1.0"

  name                = "keyvaultexample"
  resource_group_name = azurerm_resource_group.resource_group.name
  sku_name            = "standard"

  tags = {
    terraform = "true"
    padok     = "library"
  }

  depends_on = [
    azurerm_resource_group.resource_group
  ]
}

module "logger" {
  source = "../.."

  resource_group = azurerm_resource_group.resource_group


  name = "test"
  # I want to monitor both logs and metrics for my keyvault
  resources_to_logs    = [module.key_vault.this.id]
  resources_to_metrics = [module.key_vault.this.id]

}
