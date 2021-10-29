variable "resources" {
  description = "The list of resources id to monitor"
  type        = list(string)
}

variable "name" {
  description = "The name of your diagnostic settings resources"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group"
  type        = string
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
