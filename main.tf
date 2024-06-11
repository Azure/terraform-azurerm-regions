data "azurerm_client_config" "current" {}

# These resources allow the use of live data from the Azure API
data "azapi_resource_action" "compute_provider" {
  count = var.use_cached_data ? 0 : 1

  type                   = "Microsoft.Resources/subscriptions@2023-07-01"
  action                 = "providers/Microsoft.Compute"
  method                 = "GET"
  resource_id            = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  response_export_values = ["resourceTypes"]
}

data "azapi_resource_action" "locations" {
  count = var.use_cached_data ? 0 : 1

  type                   = "Microsoft.Resources/subscriptions@2022-12-01"
  action                 = "locations"
  method                 = "GET"
  resource_id            = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  response_export_values = ["value"]
}
