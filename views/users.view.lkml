view: users {
  sql_table_name: thelook.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }

  parameter: timeframe_selector {
    type: unquoted
    default_value: "week"
    allowed_value: {
      label: "Day"
      value: "date"
    }
    allowed_value: {
      label: "Week"
      value: "week"
    }
    allowed_value: {
      label: "Month"
      value: "month"
    }
    allowed_value: {
      label: "Year"
      value: "year"
    }
  }

  dimension: dynamic_timeframe {
    label_from_parameter: timeframe_selector
    sql:
      {% if timeframe_selector._parameter_value == "date" %} ${created_date}
      {% elsif timeframe_selector._parameter_value == "month" %} ${created_month}
      {% elsif timeframe_selector._parameter_value == "year" %} ${created_year}
      {% else %} ${created_week}
      {% endif %}
      ;;
  }
  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }
  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }
  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }
  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }
  dimension: lat {
    type: number
    sql: ${TABLE}.lat ;;
  }
  dimension: lng {
    type: number
    sql: ${TABLE}.lng ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }



  dimension: postcode {
    type: string
    sql: ${TABLE}.postcode ;;
  }
  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }
  parameter: location_selector{
    type: unquoted
    default_value: "zip"
    allowed_value: {label: "State" value: "state"}
    allowed_value: {label: "City" value: "city"}
    allowed_value: {label: "Zip" value: "zip"}
  }
  dimension: dynamic_location {
    type: string
    sql:
    {% if location_selector._parameter_value == "state" %} ${state}
    {% elsif location_selector._parameter_value == "city" %} ${city}
    {% else %} ${postcode}
    {% endif %}
    ;;
  }
  dimension: test_inquery {
    type: number
    sql: 100;;
    html: { % if users.city._in_query % }
             <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
         { % else % }
              <p style="color: blue; font-size:100%">{{ rendered_value }}</p>
         { % endif % };;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }
  measure: new_sum2 {
    type: sum
    sql: ${id} ;;
  }
  measure: count {
    type: count
    drill_fields: [id, first_name, last_name, orders.count]
  }
}
