{% snapshot check_name %}
    {{
        config(
            target_schema="SNAPSHOTS",
            target_database="ANALYTICS",
            unique_key="product_id",
            strategy="check",
            check_cols=["product_name", "department"],
            invalidate_hard_deletes=False,
        )
    }}

    select *
    from {{ ref("sales") }}
{% endsnapshot %}
