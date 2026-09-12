variable "location" {
  type        = string
  description = "Azure region"
}

variable "spoke_name" {
  type        = string
  description = "Name of the spoke"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the spoke VNet"
}

variable "workload_subnet_prefixes" {
  type        = list(string)
  description = "Address prefixes for the workload subnet"
}

variable "project" {
  type        = string
  description = "Name of the project"
}

variable "environment" {
  type        = string
  description = "Name of the environment"
}
