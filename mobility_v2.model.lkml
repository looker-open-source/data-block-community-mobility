#### Google Community Mobility Data ####

connection: "@{CONNECTION_NAME}"

include: "/explores/*.explore"
include: "/dashboards/*.dashboard"


#map layers
include: "map_layers.lkml"


############ Caching Logic ############

persist_with: mobility_data

### PDT Timeframes

datagroup: mobility_data {
  max_cache_age: "12 hours"
  sql_trigger:
    SELECT min(max_date) as max_date
    FROM
    (
      SELECT max(cast(date as date)) as max_date FROM `bigquery-public-data.covid19_google_mobility.mobility_report`
    ) a
  ;;
}
