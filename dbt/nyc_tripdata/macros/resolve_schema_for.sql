{% macro resolve_schema_for(model_type) -%}

    {%- set target_env_var = 'DBT__TARGET_SCHEMA'  -%}
    {%- set stging_env_var = 'DBT__STAGING_DATASET' -%}

    {%- if model_type == 'core' -%} {{- env_var(target_env_var) -}}
    {%- else -%}                    {{- env_var(stging_env_var, env_var(target_env_var)) -}}
    {%- endif -%}

{%- endmacro %}