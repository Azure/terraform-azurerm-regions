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

# This local variable is used to filter out regions in the United States that do not have zones.
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
