locals {
}


resource "azurerm_container_registry" "acr_obj" {
  name                = module.acr_name.naming_convention_output["${var.naming_convention_info.name}"].names.0
  resource_group_name = var.resource_group_name
  location            = var.location
  admin_enabled       = var.admin_enabled
  sku                 = var.sku
  public_network_access_enabled = var.public_network_access_enabled
  quarantine_policy_enabled     = var.quarantine_policy_enabled
  zone_redundancy_enabled       = var.zone_redundancy_enabled
  export_policy_enabled         = var.export_policy_enabled
  anonymous_pull_enabled        = var.anonymous_pull_enabled
  data_endpoint_enabled         = var.data_endpoint_enabled
  network_rule_bypass_option    = var.network_rule_bypass_option
    
  dynamic "encryption"  {
    for_each = var.encryption != null ? [var.encryption] : [] 
    content {
      enabled            = var.encryption.encryption_enabled
      key_vault_key_id   = var.encryption.encryption_key_vault_key_id
      identity_client_id = var.encryption.encryption_identity_client_id
  }
  }
 dynamic "retention_policy"  {
    for_each = var.retention_policy != null ? [var.retention_policy] : []
    content {
      days    = var.retention_policy.retention_policy_days
      enabled = var.retention_policy.retention_policy_enabled
  }
 }

dynamic "trust_policy"  {
    for_each = var.trust_policy != null ? [var.trust_policy] : []
    content {
      enabled = var.trust_policy.trust_policy_enabled
  }

}

dynamic "identity"  {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type = var.identity.identity_type
      identity_ids = [module.azure_msi.msi_output.id]
  }
}

dynamic "georeplications"  {
    for_each = var.georeplications != null ? [var.georeplications] : []
    content {
      location = var.georeplications.georeplications_location
      regional_endpoint_enabled = var.georeplications.georeplications_regional_endpoint_enabled
      zone_redundancy_enabled = var.georeplications.georeplications_zone_redundancy_enabled
  }

}

dynamic "network_rule_set"  {
    for_each = var.network_rule_set != null ? [var.network_rule_set] : []
    content {
      default_action = var.network_rule_set.network_rule_set_default_action
      ip_rule        = {
          action   = var.network_rule_set.network_rule_set_default_action.ip_rule.ip_rule_action
          ip_range = var.network_rule_set.network_rule_set_default_action.ip_rule.ip_rule_ip_range
      }
      virtual_network =  {
          action    = var.network_rule_set.network_rule_set_default_action.virtual_network.virtual_network_action
          subnet_id = var.network_rule_set.network_rule_set_default_action.virtual_network.virtual_network_subnet_id
      }
  }
}
  
tags                = module.acr_name.naming_convention_output["${var.naming_convention_info.name}"].tags.0

}
