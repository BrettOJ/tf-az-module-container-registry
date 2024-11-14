locals {
  naming_convention_info =  {
    name         = "002"
    project_code = "kj"
    env          = "de"
    zone         = "in"
    agency_code  = "mrl"
    tier         = "pp"
  }

    tags = {
    createdBy   = "Terraform"
    project     = "saas"
    Owner       = "konjur"
  }

  solution_plan_map  = {
      KeyVaultAnalytics = {
      "publisher" = "Microsoft"
      "product"   = "OMSGallery/KeyVaultAnalytics"
    }
  }

}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "example" {
  name     = "boj-acr-test-rg"
  location = var.location
}

module "azure_akv" {
  source              = "git::https://github.com/BrettOJ/tf-az-module-key-vault?ref=main" 
  resource_group_name = azurerm_resource_group.example.name
  location            = var.location
  sku                 = "premium"
  akv_policies = {
    sp2 = {
      object_id          = data.azurerm_client_config.current.object_id
      tenant_id          = data.azurerm_client_config.current.tenant_id
      key_permissions    = ["Create", "Get", "Delete", "Update"]
      secret_permissions = ["Get", "List", "Set"]
    }
  }
  network_acls = [
    {
      bypass         = "AzureServices"
      default_action = "Allow"
      ip_rules       = null
      subnet_ids     = null
    }
  ]

  akv_features = {
    enable_disk_encryption     = true
    enable_deployment          = true
    enable_template_deployment = true
  }
    diag_object = {
    log_analytics_workspace_id = module.log_analytics_workspace.loga_output.id
    log = [
      ["AuditEvent", true, true, 80],
    ]
    metric = [
      ["AllMetrics", true, true, 80],
    ]
  }
  naming_convention_info = local.naming_convention_info
  tags                   = local.tags
}


module "log_analytics_workspace" {
  source = "git::https://github.com/BrettOJ/tf-az-module-log-analytics?ref=main"
  resource_group_name = azurerm_resource_group.example.name
  location = var.location
  sku                 = "PerGB2018"
  #retention_in_days   = 30
  solution_plan_map = local.solution_plan_map
  tags                = local.tags
  naming_convention_info = local.naming_convention_info
}

module "azurerm_container_registry"  {
    source = "git::https://github.com/BrettOJ/tf-az-module-container-registry?ref=main"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  admin_enabled                 = var.admin_enabled
  sku                           = var.sku
  default_action                = var.default_action
  public_network_access_enabled = var.public_network_access_enabled
  quarantine_policy_enabled     = var.quarantine_policy_enabled
  zone_redundancy_enabled       = var.zone_redundancy_enabled
  export_policy_enabled         = var.export_policy_enabled
  anonymous_pull_enabled        = var.anonymous_pull_enabled
  data_endpoint_enabled         = var.data_endpoint_enabled
  network_rule_bypass_option    = var.network_rule_bypass_option
  naming_convention_info = local.naming_convention_info
  tags                = local.tags


  encryption =  {
      enabled            = var.encryption_enabled
      key_vault_key_id   = var.encryption_key_vault_key_id
      identity_client_id = var.encryption_identity_client_id
  }

  retention_policy =  {
      days    = var.retention_policy_days
      enabled = var.retention_policy_enabled
  }

  trust_policy =  {
      enabled = var.trust_policy_enabled
  }

  identity =  {
      type = var.identity_type
      identity_ids = [module.azure_msi.msi_output.id]
  }

   georeplications =  {
      location = var.georeplications_location
      regional_endpoint_enabled = var.georeplications_regional_endpoint_enabled
      zone_redundancy_enabled = var.georeplicationszone_redundancy_enabled
  }

  network_rule_set =  {
      default_action = var.network_rule_set_default_action
     ip_rule        = {
          action   = var.ip_rule_action
         ip_range = var.ip_rule_ip_range
     }
  }
 
  diag_object = {
    log_analytics_workspace_id = module.log_analytics_workspace.loga_output.id
    log                        = [["ContainerRegistryRepositoryEvents", true, true, 80]]
    metric                     = [["AllMetrics", true, true, 80], ]
  }
  
}

module "azure_msi" {
  source = "git::https://github.com/BrettOJ/tf-az-module-auth-user-msi?ref=main"
  resource_group_name = azurerm_resource_group.example.name
  location = var.location
  naming_convention_info = local.naming_convention_info
  tags                = local.tags

}

