<!-- BEGIN_TF_DOCS -->
# Default example

This example shows how to deploy the module in its simplest configuration.

```hcl
module "regions" {
  source = "../../"
}

output "regions" {
  value = module.regions.regions
}
```

<!-- markdownlint-disable MD033 -->
## Requirements

No requirements.

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