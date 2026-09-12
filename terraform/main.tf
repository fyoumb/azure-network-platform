resource "azurerm_resource_group" "mission90" {
  name     = "rg-mission90-dev"
  location = var.location
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

resource "azurerm_subnet" "hub" {
  for_each = local.hub_subnets

  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.mission90.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [each.value.prefix]
}

resource "azurerm_virtual_network_peering" "hub_to_spoke1" {
  name                      = "peer-hub-to-spoke1"
  resource_group_name       = azurerm_resource_group.mission90.name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = module.spoke1.vnet_id
}

resource "azurerm_virtual_network_peering" "spoke1_to_hub" {
  name                      = "peer-spoke1-to-hub"
  resource_group_name       = module.spoke1.resource_group_name
  virtual_network_name      = module.spoke1.vnet_name
  remote_virtual_network_id = azurerm_virtual_network.hub.id
}
