with
    source as (
        select
            o.user_id,
            p.*,
            d.department,
            a.aisle,
            o.order_id,
            o.eval_set,
            o.order_number,
            o.order_time,
            o.order_day,
            current_timestamp as created_date
        from {{ ref("stg_products") }} p
        inner join {{ ref("departments") }} d on d.department_id = p.department_id
        inner join {{ ref("stg_aisle") }} a on p.aisle_id = a.aisle_id
        inner join {{ ref("stg_orders_prior") }} op on op.product_id = p.product_id
        inner join {{ ref("stg_orders") }} o on o.order_id = op.order_id
    )

select *
from source
