locals {

  regions_zonemappings_cached_or_live = var.use_cached_data ? [for i in local.regions_zonemappings_cached.resourceTypes : i] : [for i in jsondecode(one(data.azapi_resource_action.compute_provider).output).resourceTypes : i]
  locations_cached_or_live            = var.use_cached_data ? [for i in local.locations_cached.value : i] : [for i in jsondecode(one(data.azapi_resource_action.locations).output).value : i]

  regions_zonemappings = flatten([for v in local.regions_zonemappings_cached_or_live : v.zoneMappings if v.resourceType == "virtualMachines"])
  regions_to_zones_map = { for v in local.regions_zonemappings : v.location => v.zones }
  regions_data_merged = [
    for v in local.locations_cached_or_live :
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
