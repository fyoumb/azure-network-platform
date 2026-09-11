locals {
  hub_subnets = {
    firewall = {
      name   = "AzureFirewallSubnet"
      prefix = "10.0.0.0/26"
    }

    firewall_management = {
      name   = "AzureFirewallManagementSubnet"
      prefix = "10.0.0.64/26"
    }

    bastion = {
      name   = "AzureBastionSubnet"
      prefix = "10.0.0.192/26"
    }

    shared_services = {
      name   = "SharedServicesSubnet"
      prefix = "10.0.1.0/26"
    }

    nva_workload = {
      name   = "NVA-WorkloadSubnet"
      prefix = "10.0.1.64/26"
    }

    private_endpoint = {
      name   = "PrivateEndpointSubnet"
      prefix = "10.0.1.128/26"
    }
  }
}
