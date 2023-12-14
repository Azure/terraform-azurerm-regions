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

## Credits

Belatedly adding this, waaaay overdue...

This module was created after a cool chat with [@markti](https://github.com/markti) whilst we were at Hashiconf 2023.
Thanks Mark!
