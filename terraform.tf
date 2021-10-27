terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.82.0"
    }
  }
}
provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "Workshop" {
  name = "Terraform"
}

resource "azurerm_virtual_network" "Workshop" {
  name                = "workshop-vnet"
  resource_group_name = data.azurerm_resource_group.Workshop.name
  location            = data.azurerm_resource_group.Workshop.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "A" {
  name                 = "Private-Subnet"
  resource_group_name  = data.azurerm_resource_group.Workshop.name
  virtual_network_name = azurerm_virtual_network.Workshop.name
  address_prefixes     = ["10.0.1.0/24"]
  depends_on           = [azurerm_virtual_network.Workshop]
}
resource "azurerm_subnet" "B" {
  name                 = "Public-Subnet"
  resource_group_name  = data.azurerm_resource_group.Workshop.name
  virtual_network_name = azurerm_virtual_network.Workshop.name
  address_prefixes     = ["10.0.2.0/24"]

  depends_on = [azurerm_virtual_network.Workshop]

}





