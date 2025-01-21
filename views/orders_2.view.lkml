include: "/views/orders.view.lkml"

view: +orders {


  dimension: id2 {
    #primary_key: yes
    type: number
    sql: ${TABLE}.id + 5;;
  }

  measure: new_sum1_5 {
    type: sum
    sql: ${id} +5 ;;
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
