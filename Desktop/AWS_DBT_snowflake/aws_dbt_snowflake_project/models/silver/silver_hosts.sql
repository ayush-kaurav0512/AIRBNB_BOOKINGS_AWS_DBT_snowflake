{{config(
    materialized='incremental',
    unique_key='host_id')
}}

select
    host_id,
    replace(host_name, '', '') as host_name,
    host_since as Host_since,
    IS_SUPERHOST as IS_SUPERHOST,
    RESPONSE_RATE as RESPONSE_RATE,
    Case
        when RESPONSE_RATE >95 then 'Very Good'
        when RESPONSE_RATE > 80 then 'Good'
        when RESPONSE_RATE > 60 then 'Fair'
        else 'Poor'
        end as RESPONSE_RATE_Quality    ,
        CREATED_AT as CREATED_AT
from 
    {{ref('bronze_hosts')}}