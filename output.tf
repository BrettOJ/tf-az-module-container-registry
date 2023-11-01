output "acr_output" {
  value = azurerm_container_registry.acr_obj
}

output "acr_admin_username" {
  value = azurerm_container_registry.acr_obj.admin_username
}

output "acr_admin_password" {
  value = azurerm_container_registry.acr_obj.admin_password
}
