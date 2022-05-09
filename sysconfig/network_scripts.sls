{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import sysconfig with context %}

{%- for label, cfg in sysconfig.network_scripts.items() %}
sysconfig_netcfg_{{ label | to_snake_case }}_file:
  file.managed:
    - name: /etc/sysconfig/network-scripts/{{ label }}
    - user: root
    - group: root
    - mode: 0644
    - replace: False

sysconfig_netcfg_{{ label | to_snake_case }}_content:
  file.keyvalue:
    - name: /etc/sysconfig/network-scripts/{{ label }}
    - key_values:
    {%- for option_values in cfg %}
      {%- for opt, val in option_values.items() %}
        {%- if val is sameas True %}
        {{ opt|string|upper }}: {{ "yes"|yaml_encode }}
        {%- elif val is sameas False %}
        {{ opt|string|upper }}: {{ "no"|yaml_encode }}
        {%- else %}
        {{ opt|string|upper }}: {{ val|string }}
        {%- endif %}
      {%- endfor %}
    {%- endfor %}
    - append_if_not_found: True
    - require:
      - file: sysconfig_netcfg_{{ label | to_snake_case }}_file
{%- endfor %}
