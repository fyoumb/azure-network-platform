resource "azurerm_resource_group" "spoke" {
  name     = "rg-${var.project}-${var.spoke_name}-${var.environment}"
  location = var.location

  tags = {
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "terraform"
  }
}

resource "azurerm_virtual_network" "spoke" {
  name                = "vnet-${var.spoke_name}"
  resource_group_name = azurerm_resource_group.spoke.name
  location            = var.location
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "workload" {
  name                 = "WorkloadSubnet"
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = var.workload_subnet_prefixes
}

