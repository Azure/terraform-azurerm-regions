data "azurerm_client_config" "current" {}

data "azapi_resource_action" "compute_provider" {
  type                   = "Microsoft.Resources/subscriptions@2023-07-01"
  resource_id            = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  method                 = "GET"
  action                 = "providers/Microsoft.Compute"
  response_export_values = ["*"]
}

data "azapi_resource_action" "locations" {
  type                   = "Microsoft.Resources/subscriptions@2022-12-01"
  resource_id            = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  method                 = "GET"
  action                 = "locations"
  response_export_values = ["value"]
}
