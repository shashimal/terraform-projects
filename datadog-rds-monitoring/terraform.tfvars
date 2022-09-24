datadog_api_key = "c6211a49b3c8bccc792a7504bf2eacb8"
datadog_app_key = "277aea196dc5bab404f4645cb1760dc977b2d80e"


dashboard_name = "RDS Monitoring"
dashboard_layout_type = "ordered"

# Query Value Widgets
query_value_widgets = [
  {
    type      = "query_value"
    query     = "avg:aws.rds.database_connections{dbinstanceidentifier:avenue-uat-rds-aurorapostgresinstance*}"
    title     = "DB Connections"
    live_span = "1h"
    precision = 0
  }
]

# Timeseries Widgets
timeseries_widgets = [

  {
    type      = "timeseries"
    query     = "avg:aws.rds.cpuutilization{dbinstanceidentifier:avenue-uat-rds-aurorapostgresinstance*} by {dbinstanceidentifier}"
    title     = "Cluster CPU Utilization"
    live_span = "1h"
    display_type = "line"
  },
  {
    type      = "timeseries"
    query     = "avg:aws.rds.freeable_memory{dbinstanceidentifier:avenue-uat-rds-aurorapostgresinstance*} by {dbinstanceidentifier}"
    title     = "Cluster Freeable Memory"
    live_span = "1h"
    display_type = "line"
  },
  {
    type      = "timeseries"
    query     = "avg:aws.rds.write_latency{name:avenue-uat-rds-aurorapostgresinstance*} by {dbinstanceidentifier}"
    title     = "Write Latency"
    live_span = "1h"
    display_type = "line"
  },
  {
    type      = "timeseries"
    query     = "avg:aws.rds.read_latency{dbinstanceidentifier:avenue-uat-rds-aurorapostgresinstance*} by {dbinstanceidentifier}"
    title     = "Read Latency"
    live_span = "1h"
    display_type = "line"
  }
]