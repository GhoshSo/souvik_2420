view: order_items {
  sql_table_name: thelook.order_items ;;
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
  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }
  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }
  dimension_group: returned {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.returned_at ;;
  }
  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }
  measure: count {
    type: count
    drill_fields: [id, inventory_items.id, orders.id]
  }

  filter: timeframe_current {
    type: date
  }

  filter: timeframe_previous {
    type: date
  }

  dimension: period_start_current {
    type: date_time
    sql: {% date_start timeframe_current %};;
  }

  dimension: period_end_current {
    type: date_time
    sql: {% date_end timeframe_current %};;
  }
}
#   dimension: cre_date {
#     type: date
#     sql: ${created_date} ;;
#     html:
#     {% if _user_attributes['beamer_crypto'] == 'Yes' %}
#     {{ rendered_value | date: "%d-%^b-%Y" }}

#     {% else %}
#     {{ rendered_value | date: "%d-%^b-%Y " }}
#     {% endif %};;
#   }
#   dimension: ret_date {
#     type: date
#     sql: ${returned_date} ;;
#     html:
#     {% if _user_attributes['beamer_crypto'] == 'Yes' %}
#     {{ rendered_value | date: "%d-%^b-%Y" }}

#     {% else %}
#     {{ rendered_value | date: "%d-%^b-%Y " }}
#     {% endif %};;
#   }
# }
