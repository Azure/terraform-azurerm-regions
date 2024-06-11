output "regions" {
  description = <<DESCRIPTION
A list of region objects. Each region object contains the following attributes:

- `name` - The name of the region.
- `display_name` - The display name of the region.
- `paired_region_name` - The name of the region paired with this region. May be `null` if the region has no pair.
- `geography` - The geography of the region.
- `geography_group` - The geography group of the region.
- `zones` - A list of the availability zones in the region. Will be empty if the region does not support zones.
DESCRIPTION
  value       = local.regions_recommended_or_not
}

output "regions_by_display_name" {
  description = "A map of region display names to region objects. See `regions` output for more details."
  value       = local.regions_by_display_name
}

output "regions_by_geography" {
  description = "A map of geographies to a list of region objects. See `regions` output for more details."
  value       = local.regions_by_geography
}

output "regions_by_geography_group" {
  description = "A map of geography groups to a list of region objects. See `regions` output for more details."
  value       = local.regions_by_geography_group
}

output "regions_by_name" {
  description = "A map of region display names to region objects. See `regions` output for more details."
  value       = local.regions_by_name
}

output "regions_by_name_or_display_name" {
  description = "A map of regions by either display names or name, to region objects. See `regions` output for more details."
  value       = merge(local.regions_by_display_name, local.regions_by_name)
}
