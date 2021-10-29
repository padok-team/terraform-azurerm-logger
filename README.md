# AZURE Diagnostic Settings Terraform module

Terraform module which creates a **Diagnostic Settings** resources on **Azurerm**.

## User Stories for this module

- As a DevOps Engineer, I want to be able to create a Diagnostic Settings resource on Azure.

## Usage

```hcl
module "diagnostic_settings" {
  source = "git@github.com:padok-team/terraform-azurerm-diagnostic-settings.git?ref=v0.0.1"

  resource_group_name     = "my-resource-group"
  resource_group_location = "my-location"


  name      = "test"
  resources = ["id1", "id2"]
}
```

## Examples

- [Keyvault Diagnostic settings](examples/diagnostic-settings-keyvault/main.tf)

<!-- BEGIN_TF_DOCS -->
## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of your diagnostic settings resources | `string` | n/a | yes |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | The location of the resource group | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group | `string` | n/a | yes |
| <a name="input_resources"></a> [resources](#input\_resources) | The list of resources id to monitor | `list(string)` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | The number of days to retain the logs | `number` | `30` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to assign to the resources | `map(string)` | <pre>{<br>  "terraform": "true"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_log_analytics_workspace"></a> [azurerm\_log\_analytics\_workspace](#output\_azurerm\_log\_analytics\_workspace) | The workspace name |
<!-- END_TF_DOCS -->
