SELECT f.review_id,
f.LISTING_ID,
F.REVIEWER_NAME,
F.REVIEW_DATE,
F.REVIEW_SENTIMENT,
CASE WHEN F.REVIEW_SENTIMENT = 'positive' THEN 1
     ELSE 0 END AS POSETIVE_SENTIMENT,
d.host_name, 
d.is_superhost,
d.listing_name, 
d.room_type,
d.price,
d.price_category 
FROM {{ ref('F_REVIEWS') }} f
LEFT JOIN {{ ref('DIM_HOST_LISTING') }} d
ON f.listing_id = d.listing_id
