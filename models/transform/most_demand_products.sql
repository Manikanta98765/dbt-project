with
    src as (
        select po.*, op.add_to_cart_order, op.reordered, dp.department
        from {{ ref("stg_orders_prior") }} op
        inner join {{ ref("stg_products") }} po on po.product_id = op.product_id
        inner join {{ ref("departments") }} dp on dp.department_id = po.department_id
    ),
    total as (
        select
            src.product_id,
            sum(src.add_to_cart_order) as no_of_orders_added,
            sum(src.reordered) as no_of_times_reordered
        from src
        group by src.product_id
    )
select distinct
    total.product_id,
    src.product_name,
    src.department,
    total.no_of_orders_added,
    total.no_of_times_reordered
from src
inner join total on src.product_id = total.product_id
order by total.no_of_orders_added desc, total.no_of_times_reordered desc
