view: orders {
  sql_table_name: thelook.orders ;;
  drill_fields: [id]

  dimension: id {
    #primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: status {
    type: string
    map_layer_name: my_neighborhood_layer
    sql: ${TABLE}.status ;;
  }
  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }
  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }
  measure: new_sum1 {
    type: sum
    sql: ${id} ;;
  }
  dimension: idinf {
    type: number
    value_format_name: id
    sql: 4611686018473736428 ;;
  }
  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.id, users.last_name, order_items.count]

  }

  dimension: tab_nam {
    type: string
    sql: (SELECT first_name FROM ${users.SQL_TABLE_NAME}) ;;
  }

  parameter: status_or_traffic {
    type: string
    allowed_value: {
      label: "TRAFFIC"
      value: "traffic"
    }
    allowed_value: {
      label: "STATUS"
      value: "status"

    }
    default_value: "STATUS"
  }

  dimension: user_name {
    type: string
    sql:CONCAT(${users.first_name}, " ", {% parameter status_or_traffic %}) ;;
  }

  # dimension: dyn_di {

  # }

  measure: percentage_show {
    type: number
    sql: ${id}/SUM(id) ;;
    value_format: "0.00%"
  }
  measure: total_amount_redeemed_us {
    #label: "Total Redeemed Amount [US]"
    description: "Total amount of redeemed coupons on the US market"
    type: sum
    sql: ${id}*23 ;;
    #filters: [status: "PENDING"]
    value_format_name: usd_0
    #drill_fields: [user_id, order_id, gained_coupon_details*, redemption_date]
  }
}
