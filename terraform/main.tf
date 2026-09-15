resource "azurerm_virtual_network_peering" "hub_to_spoke1" {
  name                      = "peer-hub-to-spoke1"
  resource_group_name       = module.hub.resource_group_name
  virtual_network_name      = module.hub.vnet_name
  remote_virtual_network_id = module.spokes["spoke1"].vnet_id
}

resource "azurerm_virtual_network_peering" "spoke1_to_hub" {
  name                      = "peer-spoke1-to-hub"
  resource_group_name       = module.spokes["spoke1"].resource_group_name
  virtual_network_name      = module.spokes["spoke1"].vnet_name
  remote_virtual_network_id = module.hub.vnet_id
}

resource "azurerm_virtual_network_peering" "hub_to_spoke2" {
  name                      = "peer-hub-to-spoke2"
  resource_group_name       = module.hub.resource_group_name
  virtual_network_name      = module.hub.vnet_name
  remote_virtual_network_id = module.spokes["spoke2"].vnet_id
}

resource "azurerm_virtual_network_peering" "spoke2_to_hub" {
  name                      = "peer-spoke2-to-hub"
  resource_group_name       = module.spokes["spoke2"].resource_group_name
  virtual_network_name      = module.spokes["spoke2"].vnet_name
  remote_virtual_network_id = module.hub.vnet_id
}
