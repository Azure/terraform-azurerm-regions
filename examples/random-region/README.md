<!-- BEGIN_TF_DOCS -->
# Random region

This example shows how to select a region at random.

```hcl
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

module "regions" {
  source          = "../../"
  use_cached_data = true
}

resource "random_integer" "region_index" {
  max = length(module.regions.regions) - 1
  min = 0
}

output "random_region" {
  value = module.regions.regions[random_integer.region_index.result]
}
```

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.6)

## Providers

The following providers are used by this module:

- <a name="provider_random"></a> [random](#provider\_random) (~> 3.6)

## Resources

The following resources are used by this module:

- [random_integer.region_index](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

No required inputs.

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_random_region"></a> [random\_region](#output\_random\_region)

Description: n/a

## Modules

The following Modules are called:

### <a name="module_regions"></a> [regions](#module\_regions)

Source: ../../

Version:

<!-- END_TF_DOCS -->