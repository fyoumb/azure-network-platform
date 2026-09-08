resource "azurerm_resource_group" "mission90" {
  name     = "rg-mission90-dev"
  location = "East US"
  tags = {
    Environment = "dev"
    Project     = "mission90"
    ManagedBy   = "terraform"
  }
}

resource "azurerm_virtual_network" "hub" {
  name                = "vnet-hub"
  location            = azurerm_resource_group.mission90.location
  resource_group_name = azurerm_resource_group.mission90.name
  address_space       = ["10.0.0.0/22"]
}

resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.mission90.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.0.0.128/27"]
}

locals {
  hub_subnets = {
    firewall = {
      name   = "AzureFirewallSubnet"
      prefix = "10.0.0.0/26"
    }

    firewall_management = {
      name   = "AzureFirewallManagementSubnet"
      prefix = "10.0.0.64/26"
    }

    bastion = {
      name   = "AzureBastionSubnet"
      prefix = "10.0.0.192/26"
    }

    shared_services = {
      name   = "SharedServicesSubnet"
      prefix = "10.0.1.0/26"
    }

    nva_workload = {
      name   = "NVA-WorkloadSubnet"
      prefix = "10.0.1.64/26"
    }

    private_endpoint = {
      name   = "PrivateEndpointSubnet"
      prefix = "10.0.1.128/26"
    }
  }
}

resource "azurerm_subnet" "hub" {
  for_each = local.hub_subnets

  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.mission90.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [each.value.prefix]
}

