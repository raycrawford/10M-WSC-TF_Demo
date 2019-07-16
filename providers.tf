terraform {
  required_version = "0.12.4"
}

provider "azurerm" {
  version = "~> 1.31"
}

provider "azuread" {
  version = "~> 0.4"
}

provider "random" {
  version = "~> 2.1"
}
