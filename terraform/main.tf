resource "azurerm_resource_group" "mission90" {
  name     = "rg-mission90-dev"
  location = "East US"
  tags = {
    Environment = "dev"
    Project     = "mission90"
    ManagedBy   = "terraform"
  }
}
