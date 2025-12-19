{% snapshot T_HOSTS_SNAPSHOTS %}

{{ 
  config(
    target_schema = 'snapshots',
    unique_key = 'HOST_ID',
    strategy = 'timestamp',
    updated_at = 'UPDATED_AT',
    invalidate_hard_deletes = true
  )
}}

SELECT *
FROM {{ ref('T_HOSTS') }}

{% endsnapshot %}
