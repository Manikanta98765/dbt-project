with
    source as (
        select
            order_id,
            user_id,
            eval_set,
            order_number,
            order_hour_of_day,
            cast(days_since_prior_order as varchar) as days_prior_order,
            order_dow
        from analytics.dbt_.orders_new
    )
select
    order_id,
    user_id,
    eval_set,
    order_number,
    order_hour_of_day as order_time,
    case
        when days_prior_order is null then 'new user' else days_prior_order
    end as days_prior_order,

    {% set days = [
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
    ] %}

    case
        order_dow
        {% for i in range(0, 7) %} when {{ i }} then '{{ days[i] }}' {% endfor %}
    end as order_day

from source
