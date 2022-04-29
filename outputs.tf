output "azurerm_log_analytics_workspace_id" {
  description = "The workspace ID"
  value       = var.log_analytics_workspace_id == null ? azurerm_log_analytics_workspace.this[0].id : var.log_analytics_workspace_id
}
