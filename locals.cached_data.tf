# Implement an anti-coprruption layer to transform the data from the Azure API into a format that is easier to work with in the rest of the module.
locals {
  cached_locations_list = tolist([
    for location in local.locations_cached.value : {
      display_name       = location.displayName
      geography          = location.metadata.geography
      geography_group    = location.metadata.geographyGroup
      id                 = location.id
      name               = location.name
      paired_region_name = try(one(location.metadata.pairedRegion).name, null)
      recommended        = location.metadata.regionCategory == "Recommended"
    } if location.metadata.regionType == "Physical"
  ])

  cached_zonemappings_list = tolist(flatten([
    for resource_type in local.regions_zonemappings_cached.resourceTypes : [
      for mapping in resource_type.zoneMappings : [{
        location = mapping.location
        zones    = mapping.zones
      }]
    ] if resource_type.resourceType == "virtualMachines"
  ]))
}
