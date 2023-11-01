

variable "resource_group_name" {
  description = "(Required) Map of the resource groups to create"
  type        = string
}

variable "location" {
  description = "(Required) location of the resource"
  type        = string
}

variable "sku" {
  description = "(Required)specify the sku for the acr (Basic, Standard and Premium)"
  type        = string
}


variable "default_action" {
  description = "(Optional)Specify the default network rule action"
  type        = string
  default     = "Deny"
}


# variable "diag_object" {
#   description = "contains the logs and metrics for diagnostics"
#   type = object({
#     log_analytics_workspace_id = string
#     log                        = list(tuple([string, bool, bool, number]))
#     metric                     = list(tuple([string, bool, bool, number]))
#   })
# }


# variable "naming_convention_info" {
#   description = "(Required) Specify the naming convention information to the resource."
#   type = object({
#     name         = string
#     project_code = string
#     agency_code  = string
#     env          = string
#     zone         = string
#     tier         = string
#   })
# }

variable "admin_enabled" {
  type    = bool
  default = false
}

variable "georeplications_location" {
    description = "The location of the geo-replicated container registry. The geo-replication can be created only on the Premium SKU. Possible values are: eastus, eastus2, southcentralus, westus2, australiaeast, southeastasia, northeurope, uksouth, westeurope, centralus, eastasia, japaneast, koreacentral, northcentralus, southafricaeast, westcentralus, westus, brazilsouth, canadacentral, centralindia, francecentral, germanywestcentral, japaneast, japanwest, koreacentral, koreasouth, northcentralus, northeurope, southafricanorth, southcentralus, southindia, uksouth, ukwest, westcentralus, westeurope, westindia, and westus2."
    type        = string
    default     = null
    }

variable "georeplications_regional_endpoint_enabled" {
    description = "Boolean value that indicates whether the geo-replicated container registry is enabled for the regional endpoint feature. Defaults to false."
    type        = bool
    default     = false
    }

variable "georeplicationszone_redundancy_enabled" { 
    description = "Boolean value that indicates whether the geo-replicated container registry is enabled for the zone redundancy feature. Defaults to false."
    type        = bool
    default     = false
    }

variable "network_rule_set_default_action" {
    description = "The default action of allow or deny when no other rules match. Possible values are Allow and Deny. Defaults to Deny."
    type        = string
    default     = "Deny"
    }

variable "virtual_network_action" {
    description = "The action of virtual network rule. Possible values are Allow and Deny. Defaults to Allow."
    type        = string
    default     = "Allow"
    }
  
variable "virtual_network_subnet_id" {
    description = "A list of subnet resource IDs for the virtual network rule."
    type        = string
    default     = null
    }

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed for the container registry. Defaults to true."
  type        = bool
  default     = true
}


variable "quarantine_policy_enabled" {
  description = "Boolean value that indicates whether quarantine policy is enabled."
  type        = bool
  default     = false
}

variable "retention_policy_days" {
    description = "The number of days to retain an untagged manifest after which it gets purged. The minimum value is 1 and the maximum value is 365. Defaults to 7."
    type        = number
    default     = 7
    }

variable "retention_policy_enabled" {
  description = "Boolean value that indicates whether retention policy is enabled."
  type        = bool
  default     = false
}


variable "trust_policy_enabled" {
  description = "The type of trust policy. Possible values are Notary and Signed. Defaults to Notary."
  type        = bool
  default     = true
}

variable "export_policy_enabled" {
  description = "Boolean value that indicates whether export policy is enabled. Defaults to true. In order to set it to false, make sure the public_network_access_enabled is also set to false."
  type        = bool
  default     = true
}

variable "identity_type" {
  description = "The type of identity which should be used for this Container Registry. Possible values are SystemAssigned and UserAssigned. Defaults to SystemAssigned."
  type        = string
  default     = "SystemAssigned"
}



variable "encryption_enabled" {
  description = "Boolean value that indicates whether encryption is enabled. Defaults to false."
  type        = bool
  default     = false
}

variable "encryption_key_vault_key_id" {
  description = "The Key Vault Key ID of the customer managed key to encrypt the container registry. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "encryption_identity_client_id" {
  description = "The Client ID of the identity which will be used to access key vault. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "anonymous_pull_enabled" {
  description = "Whether allows anonymous (unauthenticated) pull access to this Container Registry? This is only supported on resources with the Standard or Premium SKU."
  type        = bool
  default     = false
}

variable "data_endpoint_enabled" {
  description = "Whether to enable dedicated data endpoints for this Container Registry? This is only supported on resources with the Premium SKU."
  type        = bool
  default     = false
}

variable "network_rule_bypass_option" {
  description = "Whether to allow trusted Azure services to access a network restricted Container Registry? Possible values are None and AzureServices. Defaults to AzureServices."
  type        = string
  default     = "AzureServices"
}

variable "regional_endpoint_enabled" {
  description = "Whether regional endpoint is enabled for this Container Registry?"
  type        = bool
  default     = false
}

variable "zone_redundancy_enabled" {
  description = "Whether zone redundancy is enabled for this replication location? Defaults to false. NOTE: Changing the zone_redundancy_enabled forces the a underlying replication to be created."
  type        = bool
  default     = false
}

variable "ip_rule_action" {
  description = "The action of IP rule. Possible values are Allow and Deny. Defaults to Allow."
  type        = string
  default     = "Allow"
}

variable "ip_rule_ip_range" {
  description = "A list of IP addresses or IP address ranges in CIDR format."
  type        = string
  default     = null
}



