<!-- BEGIN_TF_DOCS -->
# Azure Regions and Availability Zones module

This module provides an output of all Azure regions and availability zones.

The module outputs a list of objects with the following attributes:

- `name` - The name of the region. E.g. "eastus"
- `display_name` - The display name of the region. E.g. "East US".
- `paired_region_name` - The name of the region paired with this region.  May be `null` if the region has no pair.
- `geography` - The geography of the region.
- `geography_group` - The geography group of the region.
- `zones` - A list of the availability zones in the region. Will be empty if the region does not support zones.

This data is the further composed into useful maps keyed by region name and region display name.

## Usage

```hcl
module "regions" {
  source = "Azure/regions/azurerm"
  version = "<version>" # change this to your desired version, https://www.terraform.io/language/expressions/version-constraints
}

output "regions" {
  value = module.regions.regions
}
```

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.0.0)

- <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (>= 1.9.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 3.74.0)

- <a name="requirement_local"></a> [local](#requirement\_local) (>= 2.4.0)

## Providers

The following providers are used by this module:

- <a name="provider_azapi"></a> [azapi](#provider\_azapi) (1.9.0)

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (3.76.0)

- <a name="provider_local"></a> [local](#provider\_local) (2.4.0)

## Resources

The following resources are used by this module:

- [azapi_resource_action.compute_provider](https://registry.terraform.io/providers/azure/azapi/latest/docs/data-sources/resource_action) (data source)
- [azapi_resource_action.locations](https://registry.terraform.io/providers/azure/azapi/latest/docs/data-sources/resource_action) (data source)
- [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) (data source)
- [local_file.compute_provider](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) (data source)
- [local_file.locations](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_use_cached_data"></a> [use\_cached\_data](#input\_use\_cached\_data)

Description: If true, the module will use cached data from the data directory. If false, the module will use live data from the Azure API.

The default is true to avoid unnecessary API calls and provide a guaranteed consistent output.  
Set to false to ensure the latest data is used.

Using data from the Azure APIs means that if the API response changes, then the module output will change.  
This may affect deployed resources that rely on this data.

Type: `bool`

Default: `true`

## Outputs

The following outputs are exported:

### <a name="output_regions"></a> [regions](#output\_regions)

Description: A list of region objects. Each region object contains the following attributes:

- `name` - The name of the region.
- `display_name` - The display name of the region.
- `paired_region_name` - The name of the region paired with this region. May be `null` if the region has no pair.
- `geography` - The geography of the region.
- `geography_group` - The geography group of the region.
- `zones` - A list of the availability zones in the region. Will be empty if the region does not support zones.

### <a name="output_regions_by_display_name"></a> [regions\_by\_display\_name](#output\_regions\_by\_display\_name)

Description: A map of region display names to region objects. See `regions` output for more details.

### <a name="output_regions_by_geography"></a> [regions\_by\_geography](#output\_regions\_by\_geography)

Description: A map of geographies to a list of region objects. See `regions` output for more details.

### <a name="output_regions_by_geography_group"></a> [regions\_by\_geography\_group](#output\_regions\_by\_geography\_group)

Description: A map of geography groups to a list of region objects. See `regions` output for more details.

### <a name="output_regions_by_name"></a> [regions\_by\_name](#output\_regions\_by\_name)

Description: A map of region display names to region objects. See `regions` output for more details.

### <a name="output_regions_by_name_or_display_name"></a> [regions\_by\_name\_or\_display\_name](#output\_regions\_by\_name\_or\_display\_name)

Description: A map of regions by either display names or name, to region objects. See `regions` output for more details.

## Modules

No modules.


<!-- END_TF_DOCS -->