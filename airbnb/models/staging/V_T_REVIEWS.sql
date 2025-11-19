{{
  config(
    materialized = 'ephemeral',
  )
}}


WITH STG_REVIEW AS (

SELECT * FROM {{ref('T_REVIEWS')}}

)


SELECT 
    LISTING_ID,
    REVIEWER_NAME,
    REVIEW_DATE,
    REVIEW_TEXT,
    --removing null values from the sentiment column
    COALESCE(REVIEW_SENTIMENT,'NA') AS REVIEW_SENTIMENT
FROM STG_REVIEW
WHERE REVIEW_TEXT IS NOT NULL
  AND REVIEW_TEXT <> ''