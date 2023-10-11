locals {
  regions_zonemappings = flatten([for v in jsondecode(data.azapi_resource_action.compute_provider.output).resourceTypes : v.zoneMappings if v.resourceType == "virtualMachines"])
  regions_to_zones_map = { for v in local.regions_zonemappings : v.location => v.zones }
  regions_data_merged = [
    for v in jsondecode(data.azapi_resource_action.locations.output).value :
    merge(
      v, { zones = lookup(local.regions_to_zones_map, v.displayName, []) }
    )
  ]
}
