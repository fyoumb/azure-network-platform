output "hub_vnet_id" {
  value = module.hub.vnet_id
}

output "spoke_vnet_ids" {
  value = {
    for key, spoke in module.spokes :
    key => spoke.vnet_id
  }
}
