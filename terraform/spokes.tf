locals {
  spokes = {
    spoke1 = {
      location                 = "eastus"
      project                  = "mission90"
      environment              = "dev"
      vnet_address_space       = ["10.1.0.0/24"]
      workload_subnet_prefixes = ["10.1.0.0/26"]
    }

    spoke2 = {
      location                 = "eastus"
      project                  = "mission90"
      environment              = "dev"
      vnet_address_space       = ["10.2.0.0/24"]
      workload_subnet_prefixes = ["10.2.0.0/26"]
    }
  }
}

module "spokes" {
  source                   = "./modules/spoke"
  for_each                 = local.spokes
  location                 = each.value.location
  project                  = each.value.project
  environment              = each.value.environment
  spoke_name               = each.key
  vnet_address_space       = each.value.vnet_address_space
  workload_subnet_prefixes = each.value.workload_subnet_prefixes
}
