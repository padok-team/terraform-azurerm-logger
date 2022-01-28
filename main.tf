resource "azurerm_log_analytics_workspace" "this" {
  name                = format("%s-workspace", var.name)
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = var.retention_in_days
  tags                = var.tags
}
data "azurerm_monitor_diagnostic_categories" "logs" {
  for_each    = var.resources_to_logs
  resource_id = each.key
}

data "azurerm_monitor_diagnostic_categories" "metrics" {
  for_each    = var.resources_to_metrics
  resource_id = each.key
}

resource "azurerm_monitor_diagnostic_setting" "logs" {
  for_each                       = var.resources_to_logs
  name                           = "Diagnostic_logs"
  target_resource_id             = each.key
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.this.id
  log_analytics_destination_type = null
  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.logs[each.key].logs
    content {
      category = log.value
      retention_policy {
        days    = 0
        enabled = false
      }
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "metrics" {
  for_each                       = var.resources_to_metrics
  name                           = "Diagnostic_Metrics"
  target_resource_id             = each.key
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.this.id
  log_analytics_destination_type = null
  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.metrics[each.key].metrics
    content {
      category = metric.value
      retention_policy {
        days    = 0
        enabled = false
      }
    }
  }
}
