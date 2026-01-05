{% macro tag(col)%}
    Case 
        When {{col}} < 100 then 'low'
        When {{col}} < 200 then 'medium'
        Else 'High'
    End
{% endmacro %}