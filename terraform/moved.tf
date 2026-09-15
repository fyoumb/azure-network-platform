moved {
  from = azurerm_resource_group.spoke1
  to   = module.spoke1.azurerm_resource_group.spoke
}

moved {
  from = azurerm_virtual_network.spoke1
  to   = module.spoke1.azurerm_virtual_network.spoke
}

moved {
  from = azurerm_subnet.spoke1_workload
  to   = module.spoke1.azurerm_subnet.workload
}

moved {
  from = azurerm_resource_group.mission90
  to   = module.hub.azurerm_resource_group.hub
}

moved {
  from = azurerm_virtual_network.hub
  to   = module.hub.azurerm_virtual_network.hub
}

moved {
  from = azurerm_subnet.gateway
  to   = module.hub.azurerm_subnet.gateway
}

moved {
  from = azurerm_subnet.hub
  to   = module.hub.azurerm_subnet.hub
}

moved {
  from = module.spoke1
  to   = module.spokes["spoke1"]
}

moved {
  from = module.spoke2
  to   = module.spokes["spoke2"]
}
