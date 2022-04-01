output "azurerm_log_analytics_workspace_id" {
  description = "The workspace ID"
  value       = try(var.log_analytics_workspace_id,azurerm_log_analytics_workspace.this[0].id)
}
