<!-- BEGIN_TF_DOCS -->
# By geography and with zones example

This example shows a more advanced scenario where you want to randomly pick two regions in a certain geography, with availability zones.

```hcl
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}

module "regions" {
  source = "../../"
}

locals {
  us_regions_with_zones = [
    for v in module.regions.regions_by_geography["United States"] : v if length(v.zones) > 1
  ]
}

resource "random_shuffle" "two_us_region_names_with_zones" {
  input        = [for v in local.us_regions_with_zones : v.name]
  result_count = 2
}

output "two_us_regions_with_zones" {
  value       = [for v in module.regions.regions : v if contains(random_shuffle.two_us_region_names_with_zones.result, v.name)]
  description = "Outputs two random US regions with zones."
}
```

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_random"></a> [random](#requirement\_random) (>= 3.1.0)

## Providers

The following providers are used by this module:

- <a name="provider_random"></a> [random](#provider\_random) (>= 3.1.0)

## Resources

The following resources are used by this module:

- [random_shuffle.two_us_region_names_with_zones](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/shuffle) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

No required inputs.

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_two_us_regions_with_zones"></a> [two\_us\_regions\_with\_zones](#output\_two\_us\_regions\_with\_zones)

Description: Outputs two random US regions with zones.

## Modules

The following Modules are called:

### <a name="module_regions"></a> [regions](#module\_regions)

Source: ../../

Version:


<!-- END_TF_DOCS -->