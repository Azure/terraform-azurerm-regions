<!-- BEGIN_TF_DOCS -->
# Default example

This example shows how to deploy the module in its simplest configuration but using live data from Azure.

```hcl
module "regions" {
  source          = "../../"
  use_cached_data = false
}

output "regions" {
  value = module.regions.regions
}
```

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.8)

## Providers

No providers.

## Resources

No resources.

<!-- markdownlint-disable MD013 -->
## Required Inputs

No required inputs.

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_regions"></a> [regions](#output\_regions)

Description: n/a

## Modules

The following Modules are called:

### <a name="module_regions"></a> [regions](#module\_regions)

Source: ../../

Version:

<!-- END_TF_DOCS -->