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
  min = 0
  max = length(module.regions.regions) - 1
}

output "random_region" {
  value = module.regions.regions[random_integer.region_index.result]
}
