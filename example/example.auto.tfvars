location            = "southeastasia"
resource_group_name = "boj-acr-test-rg"
sku                 = "Standard"

admin_enabled                 = false
default_action                = "Deny"
public_network_access_enabled = true
quarantine_policy_enabled     = false
zone_redundancy_enabled       = false
export_policy_enabled         = true

anonymous_pull_enabled        = false
data_endpoint_enabled         = false
network_rule_bypass_option    = "AzureServices"
regional_endpoint_enabled     = false
encryption_enabled           = false
encryption_key_vault_key_id = null    
encryption_identity_client_id   = null
retention_policy_days = 7
retention_policy_enabled = true
trust_policy_enabled = false
identity_type = "UserAssigned"
network_rule_set_default_action = "Deny"
ip_rule_action = "Allow"
georeplications_location ="southeastasia"