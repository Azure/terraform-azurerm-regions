locals {
  regions_zonemappings = flatten([for v in jsondecode(data.azapi_resource_action.compute_provider.output).resourceTypes : v.zoneMappings if v.resourceType == "virtualMachines"])
  regions_to_zones_map = { for v in local.regions_zonemappings : v.location => v.zones }
  regions_data_merged = [
    for v in jsondecode(data.azapi_resource_action.locations.output).value :
    merge(
      {
        name               = v.name
        display_name       = v.displayName
        paired_region_name = try(one(v.metadata.pairedRegion).name, null)
        geography          = v.metadata.geography
        geography_group    = v.metadata.geographyGroup
      },
      {
        zones = sort(lookup(local.regions_to_zones_map, v.displayName, []))
      }
    ) if v.metadata.regionType == "Physical"
  ]
  regions_by_name         = { for v in local.regions_data_merged : v.name => v }
  regions_by_display_name = { for v in local.regions_data_merged : v.display_name => v }
}
