{{ config(
     materialized='incremental', 
     unique_key='listing_id')
}}

Select
    listing_id,
    Host_id,
    property_type,
    Room_type,
    City,
    country,
    accommodates,
    BEDROOMS,
    BATHROOMS,
    Price_per_night,
    {{tag('cast(price_per_night as int)')}} AS price_per_night_tag,
    CREATED_AT
From 
    {{ref('bronze_listings')}}
