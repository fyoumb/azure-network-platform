resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  for_each                  = local.spokes
  name                      = "peer-hub-to-${each.key}"
  resource_group_name       = module.hub.resource_group_name
  virtual_network_name      = module.hub.vnet_name
  remote_virtual_network_id = module.spokes[each.key].vnet_id
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  for_each                  = local.spokes
  name                      = "peer-${each.key}-to-hub"
  resource_group_name       = module.spokes[each.key].resource_group_name
  virtual_network_name      = module.spokes[each.key].vnet_name
  remote_virtual_network_id = module.hub.vnet_id
}
