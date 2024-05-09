terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.102.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  subscription_id = "8e42d0c0-b45c-4a9d-a131-ce541ab12924"
  client_id       = "f867e890-ac25-4b34-b92b-84e55a67e285"
  client_secret   = "yXp8Q~5wZSleVlHgQF8GCKNfnNcNuTIvFuuUsb~-"
  tenant_id       = "11e75308-9a93-40ff-8430-d2562068aac5"
  features {}
}

resource "azurerm_resource_group" "app_grp" {
  name     = "app-grp"
  location = "eastus"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "terraformpractise01"
  resource_group_name      = "app-grp"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}


resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_name  = "terraformpractise01"
  container_access_type = "private"
}

resource "azurerm_storage_blob" "sample" {
  name                   = "sample.txt"
  storage_account_name   = "terraformpractise01"
  storage_container_name = "data"
  type                   = "Block"
  source                 = "sample.txt"
}
