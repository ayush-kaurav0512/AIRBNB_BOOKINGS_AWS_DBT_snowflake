{{ config(
    materialized='incremental', 
    unique_key='booking_id',
    on_schema_change='sync_all_columns')
}}

Select
    booking_id,
    listing_id,
    booking_date,
    CLEANING_FEE,
    SERVICE_FEE,
    {{ multiply('NIGHTS_BOOKED', 'BOOKING_AMOUNT', 2)}} + CLEANING_FEE + SERVICE_FEE AS TOTAL_AMOUNT,
    BOOKING_STATUS,
    CREATED_AT
From 
    {{ ref('bronze_bookings') }}

