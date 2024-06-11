locals {

  zonemappings_cached_or_live = var.use_cached_data ? local.cached_zonemappings_list : local.live_zonemappings_list

  locations_cached_or_live = var.use_cached_data ? local.cached_locations_list : local.live_locations_list

  region_to_zones_map = { for v in local.zonemappings_cached_or_live : v.location => v.zones }

  regions_data_merged = [
    for location in local.locations_cached_or_live :
    merge(
      location,
      {
        zones = sort(lookup(local.region_to_zones_map, location.display_name, []))
      }
    )
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
