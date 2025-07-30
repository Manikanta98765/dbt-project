{% snapshot snapshot_name %}
    {{
        config(
            target_schema="SNAPSHOTS",
            target_database="ANALYTICS",
            unique_key="product_id",
            strategy="timestamp",
            invalidate_hard_deletes=False,
            updated_at="created_date",
        )
    }}

    select *
    from {{ ref("sales") }}
{% endsnapshot %}
