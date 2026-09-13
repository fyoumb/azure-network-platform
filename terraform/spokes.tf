module "spoke1" {
  source                   = "./modules/spoke"
  location                 = var.location
  project                  = "mission90"
  environment              = "dev"
  spoke_name               = "spoke1"
  vnet_address_space       = ["10.1.0.0/24"]
  workload_subnet_prefixes = ["10.1.0.0/26"]
}

module "spoke2" {
  source                   = "./modules/spoke"
  location                 = var.location
  project                  = "mission90"
  environment              = "dev"
  spoke_name               = "spoke2"
  vnet_address_space       = ["10.2.0.0/24"]
  workload_subnet_prefixes = ["10.2.0.0/26"]
}
