variable "datadog_api_key" {
  type = string
}

variable "datadog_app_key" {
  type = string
}

variable "dashboard_name" {
  type = string
}

variable "dashboard_layout_type" {
  type = string
}

variable "query_value_widgets" {
  type = list(object({
    type = string
    query = string
    title = string
    live_span = string
    precision = number
  }))
}

variable "timeseries_widgets" {
  type = list(object({
    type = string
    display_type = string
    query = string
    title = string
    live_span = string
  }))
}