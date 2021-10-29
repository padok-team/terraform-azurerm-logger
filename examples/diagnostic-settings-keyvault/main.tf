# This example deploys a keyvault and configure it to send the keyvault metrics to a log analytics workspace.
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

module "resource_group" {
  ## Specify Version with the ref property
  source = "git@github.com:padok-team/terraform-azurerm-resource-group.git?ref=v0.0.2"

  name     = "examplerg"
  location = "West Europe"

  tags = {
    terraform = "true"
    padok     = "library"
  }
}

module "key_vault" {
  source = "git@github.com:padok-team/terraform-azurerm-keyvault.git?ref=v0.0.1"

  name                = "myexamplekeyvault"
  resource_group_name = module.resource_group.this.name
  sku_name            = "standard"

  tags = {
    terraform = "true"
    padok     = "library"
  }

  depends_on = [
    module.resource_group
  ]
}

module "diagnostic_settings" {
  source = "../.."

  resource_group_name     = module.resource_group.this.name
  resource_group_location = module.resource_group.this.location


  name      = "test"
  resources = [module.key_vault.this.id]

}
