select *
from {{ ref("stg_orders") }} a
where
    a.user_id is not null and not regexp_like(user_id, '^[0-9]$') and len(a.user_id) = 1
