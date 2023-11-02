

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
  default = "Basic"
}

variable "allowed_subnets" {
  description = "(Optional)contains the list of subnets to allow access"
  default     = null
  type        = list(string)
}

variable "default_action" {
  description = "(Optional)Specify the default network rule action"
  type        = string
  default     = "Deny"
}


variable "diag_object" {
  description = "contains the logs and metrics for diagnostics"
  type = object({
    log_analytics_workspace_id = string
    log                        = list(tuple([string, bool, bool, number]))
    metric                     = list(tuple([string, bool, bool, number]))
  })
}


variable "naming_convention_info" {
  description = "(Required) Specify the naming convention information to the resource."
  type = object({
    name         = string
    project_code = string
    agency_code  = string
    env          = string
    zone         = string
    tier         = string
  })
}

variable "tags" {
  type        = map(string)
  description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}

variable "admin_enabled" {
  type    = bool
  default = false
}

variable "public_network_access_enabled" {
  type = string
  default = null
  description = "(Optional) Enable or Disable public network access for the container registry. Defaults to true."
}

variable "quarantine_policy_enabled" {
  type = string
  default = null
  description = "(Optional) Enable or Disable quarantine policy for the container registry. Defaults to false."
}

variable "zone_redundancy_enabled" {
  type = string
  default = null
  description = "(Optional) Enable or Disable zone redundancy for the container registry. Defaults to false."
}

variable "export_policy_enabled" {
  type = string
  default = null
  description = "(Optional) Enable or Disable export policy for the container registry. Defaults to false."
}

variable "anonymous_pull_enabled" {
  type = string
  default = null
  description = "(Optional) Enable or Disable anonymous pull for the container registry. Defaults to false."
}

variable "data_endpoint_enabled" {
  type = string
  default = null
  description = "(Optional) Enable or Disable data endpoint for the container registry. Defaults to false."
}

variable "network_rule_bypass_option" {
  type = string
  default = null
  description = "(Optional) Enable or Disable network rule bypass option for the container registry. Defaults to AzureServices."
}

variable "encryption" {
  type = object({
    enabled         = bool
    key_vault_key_id = string
    identity_client_id = string
  })
  default = null
  description = "(Optional) Enable or Disable encryption for the container registry. Defaults to false."
}

variable "retention_policy" {
  type = object({
    days    = number
    enabled = bool
  })
  default = null
  description = "(Optional) Enable or Disable retention policy for the container registry. Defaults to false."
}

variable "identity" {
  type = object({
    type = string
    ids  = list(string)
  })
  default = null
  description = "(Optional) Enable or Disable identity for the container registry. Defaults to false."
}

variable "trust_policy" {
  type = object({
    enabled = bool
  })
  default = null
  description = "(Optional) Enable or Disable trust policy for the container registry. Defaults to false."
}

variable "georeplications" {
  type = object({
    location = string
    regional_endpoint_enabled = bool
    zone_redundancy_enabled = bool
  })
  default = null
  description = "(Optional) Enable or Disable georeplications for the container registry. Defaults to false."
}

variable "network_rule_set" {
  type = object({
    default_action = string
    ip_rule = object({
      action   = string
      ip_range = string
    })
    virtual_network = object({
      action    = string
      subnet_id = string
    })
  })
  default = null
  description = "(Optional) Enable or Disable network rule set for the container registry. Defaults to false."
}



