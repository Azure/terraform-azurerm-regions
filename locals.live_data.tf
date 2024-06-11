# Implement an anti-coprruption layer to transform the data from the Azure API into a format that is easier to work with in the rest of the module.
locals {
  live_locations_list = !var.use_cached_data ? [
    for location in jsondecode(data.azapi_resource_action.locations[0].output).value : {
      display_name       = location.displayName
      geography          = location.metadata.geography
      geography_group    = location.metadata.geographyGroup
      id                 = location.id
      name               = location.name
      paired_region_name = try(one(location.metadata.pairedRegion).name, null)
      recommended        = location.metadata.regionCategory == "Recommended"
    } if location.metadata.regionType == "Physical"
  ] : null

  live_zonemappings_list = !var.use_cached_data ? tolist(flatten([
    for resource_type in jsondecode(one(data.azapi_resource_action.compute_provider).output).resourceTypes : [
      for mapping in resource_type.zoneMappings : [{
        location = mapping.location
        zones    = sort([for zone in mapping.zones : tonumber(zone)])
      }]
    ] if resource_type.resourceType == "virtualMachines"
  ])) : null
}
