variable "location" {
  type        = string
  description = "Azure region"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the hub VNet"
}

variable "project" {
  type        = string
  description = "Name of the project"
}

variable "environment" {
  type        = string
  description = "Name of the environment"
}
