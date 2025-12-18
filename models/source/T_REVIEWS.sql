WITH RAW_REVIEWS AS (
    SELECT *
    FROM {{ source('airbnb', 'reviews') }}
)

SELECT 
    listing_id,
    DATE AS review_date,
    REVIEWER_NAME AS REVIEWER_NAME,
    comments AS review_text,
    sentiment AS review_sentiment
FROM RAW_REVIEWS