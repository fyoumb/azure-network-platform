module "spoke1" {
  source                   = "./modules/spoke"
  location                 = var.location
  project                  = "mission90"
  environment              = "dev"
  spoke_name               = "spoke1"
  vnet_address_space       = ["10.1.0.0/24"]
  workload_subnet_prefixes = ["10.1.0.0/26"]
}
