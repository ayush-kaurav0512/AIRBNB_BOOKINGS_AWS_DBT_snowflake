{% set cols = ['NIGHTS_BOOKED', 'BOOKING_ID', 'BOOKING_AMOUNT']%}

select
{% for col in cols%}
    {{ col}}
    {% if not loop.last %},{% endif %}
{% endfor %}
FROM {{ ref('bronze_bookings') }}