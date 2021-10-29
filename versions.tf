terraform {
  required_version = ">= 0.13.0"

  required_providers {
    aws = {
      source  = "hashicorp/azurerm"
      version = ">= 2.82"
    }
  }
}
