# Azure Logger Terraform module

Terraform module which creates a **Log Analytics Workspace** and **Diagnostic Settings** resources to collect logs and/or metrics for a given list of resources on **Azurerm**.

## User Stories for this module

- AAOps I can create a log analytics workspace and collect logs from Azure resources.
- AAOps I can create a log analytics workspace and collect metrics from Azure resources.
- AAOps I can create a log analytics workspace and collect logs and/or metrics from Azure resources.

## Usage

```hcl
module "logger" {
  source = "git@github.com:padok-team/terraform-azurerm-logger.git?ref=v0.2.0"

  resource_group_name     = "my-resource-group"
  resource_group_location = "my-location"

  name      = "test"
  resources_to_logs = ["<id-of-resource-1>", "<id-of-resource-2>"]
  resources_to_metrics = ["<id-of-resource-1>"]
}
```

## Examples

- [Log Analytic Workspace logger collecting logs and metrics](examples/log-analytics-workspace-logger-logs-and-metrics/main.tf)
- [Log Analytic Workspace logger collecting metrics only](examples/log-analytics-workspace-logger-metrics-only/main.tf)

<!-- BEGIN_TF_DOCS -->
## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of your diagnostic settings resources | `string` | n/a | yes |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | The location of the resource group | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group | `string` | n/a | yes |
| <a name="input_resources_to_logs"></a> [resources\_to\_logs](#input\_resources\_to\_logs) | The list of resources id to log | `list(string)` | `[]` | no |
| <a name="input_resources_to_metrics"></a> [resources\_to\_metrics](#input\_resources\_to\_metrics) | The list of resources id to metric | `list(string)` | `[]` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | The number of days to retain the logs | `number` | `30` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to assign to the resources | `map(string)` | <pre>{<br>  "terraform": "true"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_log_analytics_workspace_id"></a> [azurerm\_log\_analytics\_workspace\_id](#output\_azurerm\_log\_analytics\_workspace\_id) | The workspace ID |
<!-- END_TF_DOCS -->

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

```text
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
```
