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

  validation {
    condition = alltrue([
      for prefix in var.workload_subnet_prefixes :
      can(cidrhost(prefix, 0))
    ])
    error_message = "All workload subnet prefixes must be valid CIDR blocks."
  }
}

variable "project" {
  type        = string
  description = "Name of the project"
}

variable "environment" {
  type        = string
  description = "Name of the environment"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be dev, test, or prod."
  }
}
