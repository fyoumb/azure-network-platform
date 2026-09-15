output "hub_vnet_id" {
  value = module.hub.vnet_id
}

output "spoke1_vnet_id" {
  value = module.spokes["spoke1"].vnet_id
}

output "spoke2_vnet_id" {
  value = module.spokes["spoke2"].vnet_id
}
