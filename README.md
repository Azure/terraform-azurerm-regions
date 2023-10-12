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

## Providers

The following providers are used by this module:

- <a name="provider_azapi"></a> [azapi](#provider\_azapi) (1.9.0)

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (3.75.0)

## Resources

The following resources are used by this module:

- [azapi_resource_action.compute_provider](https://registry.terraform.io/providers/azure/azapi/latest/docs/data-sources/resource_action) (data source)
- [azapi_resource_action.locations](https://registry.terraform.io/providers/azure/azapi/latest/docs/data-sources/resource_action) (data source)
- [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

No required inputs.

## Optional Inputs

No optional inputs.

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

### <a name="output_regions_by_name"></a> [regions\_by\_name](#output\_regions\_by\_name)

Description: A map of region display names to region objects. See `regions` output for more details.

## Modules

No modules.


<!-- END_TF_DOCS -->