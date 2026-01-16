
{{
  config(
    materialized = 'incremental',
    on_schema_change='fail',
    cluster_by = ['REVIEW_DATE'],  
    incremental_strategy = 'merge'
  )
}}

WITH R AS (
    SELECT * FROM {{ref('T_REVIEWS')}}
)
SELECT 
   {{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date']) }} as review_id,
    LISTING_ID,
    REVIEWER_NAME,
    REVIEW_DATE,
    REVIEW_TEXT,
    REVIEW_SENTIMENT
FROM R
WHERE review_text is not null

{% if is_incremental() %}

  {% if var("start_date", False) and var("end_date", False) %}
    {{ log('Loading ' ~ this ~ ' incrementally (start_date: ' ~ var("start_date") ~ ', end_date: ' ~ var("end_date") ~ ')', info=True) }}
    AND review_date >= '{{ var("start_date") }}'
    AND review_date < '{{ var("end_date") }}'
  {% else %}
    AND review_date > (select max(review_date) from {{ this }})
    {{ log('Loading ' ~ this ~ ' incrementally (all missing dates)', info=True)}}
  {% endif %}

{%endif%}