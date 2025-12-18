WITH RAW_HOSTS AS (
    SELECT * FROM {{ source('airbnb', 'hosts') }}
)


SELECT
    id AS HOST_ID ,
    NAME AS HOST_NAME,
    is_superhost AS IS_SUPERHOST,
    CREATED_AT,
    UPDATED_AT
FROM RAW_HOSTS

