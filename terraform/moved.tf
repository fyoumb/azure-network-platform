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

