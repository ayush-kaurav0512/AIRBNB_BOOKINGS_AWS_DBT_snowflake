 {% set flag = 2  %}

 {% set nights_booked = 1 %}

select * from {{ref('bronze_bookings')}}
{% if flag == 1%}
    where NIGHTS_BOOKED > {{ nights_booked }}
{% else %}
    where NIGHTS_BOOKED <= {{ nights_booked }}
{% endif %}