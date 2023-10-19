locals {

  regions_zonemappings_cached_or_live = var.use_cached_data ? data.local_file.compute_provider.content : one(data.azapi_resource_action.compute_provider).output
  locations_cached_or_live            = var.use_cached_data ? data.local_file.locations.content : one(data.azapi_resource_action.locations).output

  regions_zonemappings = flatten([for v in jsondecode(local.regions_zonemappings_cached_or_live).resourceTypes : v.zoneMappings if v.resourceType == "virtualMachines"])
  regions_to_zones_map = { for v in local.regions_zonemappings : v.location => v.zones }
  regions_data_merged = [
    for v in jsondecode(local.locations_cached_or_live).value :
    merge(
      {
        name               = v.name
        display_name       = v.displayName
        paired_region_name = try(one(v.metadata.pairedRegion).name, null)
        geography          = v.metadata.geography
        geography_group    = v.metadata.geographyGroup
        recommended        = v.metadata.regionCategory == "Recommended"
      },
      {
        zones = sort(lookup(local.regions_to_zones_map, v.displayName, []))
      }
    ) if v.metadata.regionType == "Physical"
  ]

  regions_recommended_or_not = var.recommended_regions_only ? [for v in local.regions_data_merged : v if v.recommended] : local.regions_data_merged

  regions_by_name         = { for v in local.regions_recommended_or_not : v.name => v }
  regions_by_display_name = { for v in local.regions_recommended_or_not : v.display_name => v }

  geos       = distinct([for v in local.regions_recommended_or_not : v.geography])
  geo_groups = distinct([for v in local.regions_recommended_or_not : v.geography_group])

  regions_by_geography = {
    for geo in local.geos : geo => [
      for v in local.regions_recommended_or_not : v if v.geography == geo
    ]
  }

  regions_by_geography_group = {
    for geo_group in local.geo_groups : geo_group => [
      for v in local.regions_recommended_or_not : v if v.geography_group == geo_group
    ]
  }
}
