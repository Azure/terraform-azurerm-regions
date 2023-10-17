module "regions" {
  source          = "../../"
  use_cached_data = false
}

output "regions" {
  value = module.regions.regions
}
