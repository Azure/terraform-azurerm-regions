variable "recommended_regions_only" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
If true, the module will only return regions that are have the category set to `Recommended` by the locations API.
DESCRIPTION
}

variable "use_cached_data" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
If true, the module will use cached data from the data directory. If false, the module will use live data from the Azure API.

The default is true to avoid unnecessary API calls and provide a guaranteed consistent output.
Set to false to ensure the latest data is used.

Using data from the Azure APIs means that if the API response changes, then the module output will change.
This may affect deployed resources that rely on this data.
DESCRIPTION
}
