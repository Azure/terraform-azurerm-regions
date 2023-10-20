terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1"
    }
  }
}

module "regions" {
  source = "../../"
}

resource "random_integer" "region_index" {
  min = 0
  max = length(module.regions.regions) - 1
}


output "random_region" {
  value = module.regions.regions[random_integer.region_index.result]
}
