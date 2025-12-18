
{{
  config(
    materialized = 'incremental',
    on_schema_change='fail',
    cluster_by = ['REVIEW_DATE'],  
    incremental_strategy = 'merge'
  )
}}

WITH R AS (
    SELECT * FROM {{ref('V_T_REVIEWS')}}
)
SELECT 
    LISTING_ID,
    REVIEWER_NAME,
    REVIEW_DATE,
    REVIEW_TEXT,
    REVIEW_SENTIMENT
FROM R

{% if is_incremental() %}

WHERE REVIEW_DATE > (SELECT COALESCE(MAX(REVIEW_DATE), '1900-01-01') FROM {{ this }})

{%endif%}