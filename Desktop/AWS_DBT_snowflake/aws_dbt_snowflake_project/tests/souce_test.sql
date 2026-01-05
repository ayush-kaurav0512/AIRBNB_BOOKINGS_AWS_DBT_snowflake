{{config(
    severity='warn'
)}}

SELECT 
    1 
FROM
    {{soure('staging','bookings')}}
WHERE
    BOOKING_AMOUNT <200;