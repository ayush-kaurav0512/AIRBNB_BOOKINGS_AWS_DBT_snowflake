{% set configs = [
    {
        "table" : "AIRBNB.silver.silver_BOOKINGS",
        "columns" : "silver_bookings.* ",
        "alias" : "silver_bookings" 
    },

    {
        "table" : "AIRBNB.silver.silver_LISTINGS",
        "columns" : "silver_listings.HOST_ID, silver_listings.PROPERTY_TYPE, silver_listings.ROOM_TYPE, silver_listings.CITY, silver_listings.COUNTRY, silver_listings.ACCOMMODATES, silver_listings.BEDROOMS, silver_listings.BATHROOMS, silver_listings.PRICE_PER_NIGHT, silver_listings.PRICE_PER_NIGHT_TAG, silver_listings.CREATED_AT AS LISTING_CREATED_AT",
        "alias" : "silver_listings",
        "join_condition" : "silver_bookings.listing_id = silver_listings.listing_id"
    },

    {
        "table" : "AIRBNB.silver.silver_HOSTS",
        "columns" : "silver_hosts.HOST_NAME, silver_hosts.HOST_SINCE, silver_hosts.IS_SUPERHOST, silver_hosts.RESPONSE_RATE_QUALITY, silver_hosts.RESPONSE_RATE, silver_hosts.CREATED_AT AS HOST_CREATED_AT",
        "alias" : "silver_Hosts",
        "join_condition" : "silver_listings.host_id = silver_hosts.host_id"
    }
]%} 


Select
    {% for config in configs %}
        {{config['columns']}}{% if not loop.last %},{% endif %}
    {% endfor %}
From 
    {% for config in configs %}
    {% if loop.first %}
        {{config['table']}} AS {{config['alias']}}
    {% else %}
        LEFT JOIN {{config['table']}} AS {{config['alias']}}
        ON {{config['join_condition']}}
        {% endif %}
    {% endfor %}