WITH RAW_LISTING AS (
SELECT *
FROM  {{ source('airbnb', 'listings') }}

)


SELECT 
   id AS LISTING_ID,
   listing_url AS LISTING_URL,
   name AS LISTING_NAME,
   room_type AS ROOM_TYPE,
   minimum_nights AS MINIMUM_NIGHTS,
   host_id AS HOST_ID,
   price AS PRICE,
   CREATED_AT,
   UPDATED_AT
FROM RAW_LISTING

