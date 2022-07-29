variable "resources_to_logs" {
  description = "The list of resources id to log"
  type        = list(string)
  default     = []
}

variable "resources_to_metrics" {
  description = "The list of resources id to metric"
  type        = list(string)
  default     = []
}

variable "name" {
  description = "The name of your diagnostic settings resources"
  type        = string
  default     = ""
}

variable "resource_group" {
  description = "The resource group resource."
  type = object({
    name     = string
    location = string
  })
}

variable "retention_in_days" {
  description = "The number of days to retain the logs"
  type        = number
  default     = 30
}

variable "tags" {
  description = "The tags to assign to the resources"
  type        = map(string)
  default = {
    terraform = "true"
  }
}
variable "log_analytics_workspace_id" {
  type = string
  description = "ID of log analytics workspace if you do not want to create one, but use your own"
  default = null
}
