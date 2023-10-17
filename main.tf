data "azurerm_client_config" "current" {}

# These resources allow the use of live data from the Azure API
data "azapi_resource_action" "compute_provider" {
  count                  = var.use_cached_data ? 0 : 1
  type                   = "Microsoft.Resources/subscriptions@2023-07-01"
  resource_id            = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  method                 = "GET"
  action                 = "providers/Microsoft.Compute"
  response_export_values = ["resourceTypes"]
}

data "azapi_resource_action" "locations" {
  count                  = var.use_cached_data ? 0 : 1
  type                   = "Microsoft.Resources/subscriptions@2022-12-01"
  resource_id            = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  method                 = "GET"
  action                 = "locations"
  response_export_values = ["value"]
}


# These resources allow the use of consistent local data files, and semver versioning
data "local_file" "compute_provider" {
  filename = "${path.module}/data/microsoft.compute_resourceTypes.json"
}

data "local_file" "locations" {
  filename = "${path.module}/data/locations.json"
}
