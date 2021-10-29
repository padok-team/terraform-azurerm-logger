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

resource "random_string" "random" {
  length  = 5
  special = false
  number  = true
  upper   = false
}

module "resource_group" {
  ## Specify Version with the ref property
  source = "git@github.com:padok-team/terraform-azurerm-resource-group.git?ref=v0.0.2"

  name     = "example${random_string.random.result}"
  location = "West Europe"

  tags = {
    terraform = "true"
    padok     = "library"
  }
}

module "key_vault" {
  source = "git@github.com:padok-team/terraform-azurerm-keyvault.git?ref=v0.0.1"

  name                = "mykeyvault${random_string.random.result}"
  resource_group_name = module.resource_group.this.name
  sku_name            = "standard"

  tags = {
    terraform = "true"
    padok     = "library"
  }
}

module "diagnostic_settings" {
  source = "../.."

  resource_group_name     = module.resource_group.this.name
  resource_group_location = module.resource_group.this.location


  name      = "test"
  resources = [module.key_vault.this.id]

}
