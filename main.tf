resource "azurerm_log_analytics_workspace" "this" {
  count = var.create_new_workspace ? 1 : 0

  name                = var.name
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  sku                 = "PerGB2018"
  retention_in_days   = var.retention_in_days
  tags                = var.tags
}

data "azurerm_monitor_diagnostic_categories" "logs" {
  count       = length(var.resources_to_logs)
  resource_id = var.resources_to_logs[count.index]
}

data "azurerm_monitor_diagnostic_categories" "metrics" {
  count       = length(var.resources_to_metrics)
  resource_id = var.resources_to_metrics[count.index]
}

resource "azurerm_monitor_diagnostic_setting" "logs" {
  count = length(var.resources_to_logs)

  name                       = "Diagnostic_logs"
  target_resource_id         = var.resources_to_logs[count.index]
  log_analytics_workspace_id = var.log_analytics_workspace_id == null ? azurerm_log_analytics_workspace.this[0].id : var.log_analytics_workspace_id
  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.logs[count.index].logs
    content {
      category = enabled_log.value
      retention_policy {
        enabled = false
        days    = 0
      }
    }
  }
  // Empty metric to not polute terraform plan/apply
  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.logs[count.index].metrics
    content {
      category = metric.value
      enabled  = false
      retention_policy {
        enabled = false
        days    = 0
      }
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "metrics" {
  count = length(var.resources_to_metrics)

  name                       = "Diagnostic_Metrics"
  target_resource_id         = var.resources_to_metrics[count.index]
  log_analytics_workspace_id = var.log_analytics_workspace_id == null ? azurerm_log_analytics_workspace.this[0].id : var.log_analytics_workspace_id
  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.metrics[count.index].metrics
    content {
      category = metric.value
      retention_policy {
        enabled = false
        days    = 0
      }
    }
  }
}
