terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

locals {

  # Datadog Query Value widgets
  query_value_widgets = [
  for query_value in var.query_value_widgets : {
    definition = {
      title     = query_value["title"]
      type      = query_value["type"],
      precision = query_value["precision"]
      time : {
        live_span = query_value["live_span"]
      },
      requests = [
        {
          q = query_value["query"]
        }
      ]
    }
  }
  ]

  # DataDog Timeseries widgets
  timeseries_widgets = [

  for timeseries in var.timeseries_widgets : {
    definition = {
      title = timeseries["title"]
      type  = timeseries["type"],
      time : {
        live_span = timeseries["live_span"]
      },
      requests = [
        {
          q            = timeseries["query"]
          display_type = timeseries["display_type"]
        }
      ]
    }
  }

  ]

  # Combine all widgets
  dashboard_widgets = concat(local.query_value_widgets, local.timeseries_widgets)

}

/*
 Creating Datadog dashboard for monitoring AWS RDS
*/
resource "datadog_dashboard_json" "rds-dashboard" {

  dashboard = jsonencode({
    title       = var.dashboard_name
    layout_type = var.dashboard_layout_type
    widgets     = local.dashboard_widgets
  }
  )
}


output "widgets" {
  value = local.dashboard_widgets
}
