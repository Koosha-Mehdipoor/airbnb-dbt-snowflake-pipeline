{{
    config(
        materialized = 'table'
    )
    
    }}


WITH reviews AS (
    SELECT * FROM {{ref('F_REVIEWS')}}
),
full_moon_dates AS (
    SELECT *
    FROM {{ref('seed_full_moon_dates')}}
)
SELECT reviews.*, full_moon_dates.full_moon_date,
        CASE WHEN full_moon_date IS NOT NULL THEN 'FULL MOON' ELSE 'NOT FULL MOON' END AS IS_FULL_MOON_REVIEW
FROM reviews
LEFT JOIN full_moon_dates
ON TO_DATE(reviews.REVIEW_DATE) = TO_DATE(DATEADD(day, 1, full_moon_dates.FULL_MOON_DATE))