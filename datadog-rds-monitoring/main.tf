terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

module "dashboard" {
  source = "./modules/dashborad"
  query_value_widgets = var.query_value_widgets
  timeseries_widgets = var.timeseries_widgets
  dashboard_name = var.dashboard_name
  dashboard_layout_type = var.dashboard_layout_type
}

output "widgets" {
  value = "${module.dashboard.widgets}"
}