{{
    config(
        materialized = 'table'
    )
    
    }}


WITH H AS (
    SELECT * FROM {{ref('V_T_HOSTS')}}
),
L AS (
    SELECT * FROM {{ref('V_T_LISTING')}}
)
SELECT 
    L.LISTING_ID,
    H.HOST_ID,
    H.HOST_NAME,
    H.IS_SUPERHOST,
    L.LISTING_URL,
    L.LISTING_NAME,
    L.ROOM_TYPE,
    L.PRICE,
    GREATEST(H.CREATED_AT, L.CREATED_AT) AS CREATED_AT,
    GREATEST(H.UPDATED_AT, L.UPDATED_AT) AS UPDATED_AT

FROM H 
LEFT JOIN L
ON H.HOST_ID = L.HOST_ID