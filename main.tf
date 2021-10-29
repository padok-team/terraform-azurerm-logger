resource "azurerm_log_analytics_workspace" "this" {
  name                = format("%s-workspace", var.name)
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = var.retention_in_days
  tags                = var.tags
}
data "azurerm_monitor_diagnostic_categories" "this" {
  count       = length(var.resources)
  resource_id = var.resources[count.index]
}
resource "azurerm_monitor_diagnostic_setting" "this" {
  count                          = length(var.resources)
  name                           = "Diagnostic"
  target_resource_id             = var.resources[count.index]
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.this.id
  log_analytics_destination_type = null
  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[count.index].logs
    content {
      category = log.value
      retention_policy {
        days    = 0
        enabled = false
      }
    }
  }
  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[count.index].metrics
    content {
      category = metric.value
      retention_policy {
        days    = 0
        enabled = false
      }
    }
  }
}
