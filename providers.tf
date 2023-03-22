terraform {
  required_version = ">=1.4.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.47.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.4.3"
    }
    tls = {
      source = "hashicorp/tls"
      version = "~>4.0.4"
    }
  }
}

provider "azurerm" {
  features {}
}