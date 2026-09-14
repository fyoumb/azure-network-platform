module "hub" {
  source = "./modules/hub"

  location           = var.location
  project            = "mission90"
  environment        = "dev"
  vnet_address_space = ["10.0.0.0/22"]
}
