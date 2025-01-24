view: orders {
  sql_table_name: thelook.orders ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
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

  measure: sum_kg {
    type: sum_distinct
    view_label: "Volume"
    label: "   KG"
    description: "Total Kilogram Weight Quantity"
    sql_distinct_key: ${traffic_source} ;;
    sql: cast(${TABLE}.user_id AS decimal(28,10));;
    precision:0
  }

  measure: sum_iu {
    type: sum_distinct
    view_label: "Volume"
    label: "  IU"
    description: "Total International Unit Weight Quantity"
    sql_distinct_key: ${traffic_source} ;;
    sql: cast(${TABLE}.user_id AS decimal(28,2));;
  }

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.id, users.last_name, order_items.count]
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
