{% macro cast_or_null(col, dtype='INT') %}
    CASE
        WHEN {{ col }} IS NULL OR {{ col }} = 'NA' THEN NULL
        ELSE CAST({{ col }} AS {{ dtype }})
    END
{% endmacro %}