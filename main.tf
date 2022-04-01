resource "azurerm_log_analytics_workspace" "this" {
  name                = format("%s-workspace", var.name)
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
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
  count                          = length(var.resources_to_logs)
  name                           = "Diagnostic_logs"
  target_resource_id             = var.resources_to_logs[count.index]
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.this.id
  log_analytics_destination_type = null
  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.logs[count.index].logs
    content {
      category = log.value
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
  count                          = length(var.resources_to_metrics)
  name                           = "Diagnostic_Metrics"
  target_resource_id             = var.resources_to_metrics[count.index]
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.this.id
  log_analytics_destination_type = null
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
  // Empty log to not polute terraform plan/apply
  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.metrics[count.index].logs
    content {
      category = log.value
      enabled  = false
      retention_policy {
        enabled = false
        days    = 0
      }
    }
  }
}
