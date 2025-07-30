{% macro Days() %}

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
    end

{% endmacro %}
