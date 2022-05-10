{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import sysconfig with context %}

{%- for label, cfg in sysconfig.network_scripts.items() %}

{%- if cfg is string %}

{%- if cfg == 'absent' %}
sysconfig_netcfg_{{ label | to_snake_case }}_file_absent:
  file.absent:
    - name: /etc/sysconfig/network-scripts/{{ label }}
{%- else %}
sysconfig_netcfg_{{ label | to_snake_case }}_file_managed:
  file.managed:
    - name: /etc/sysconfig/network-scripts/{{ label }}
    - user: root
    - group: root
    - mode: 0644
    - contents: {{ cfg | yaml }}
{%- endif %}

{%- else %}

{#- Convert list of key-values to dict #}
{%- set cfg_dict = {} %}
{%- if cfg is mapping %}
{%-   set cfg_dict = cfg %}
{%- elif cfg is sequence %}
{%-   for item in cfg %}
{%-     for k, v in item.items() %}
{%-       do cfg_dict.update({k: v}) %}
{%-     endfor %}
{%-   endfor %}
{%- endif %}

{#- Generate key_values for file.keyvalue state #}
{%- set opts = {} %}
{%- set opts_to_remove = {} %}
{%- for k, v in cfg_dict.items() %}
{%-   set k = k|upper %}
{%-   if v is sameas true %}
{%-     do opts.update({k: 'yes'}) %}
{%-   elif v is sameas false %}
{%-     do opts.update({k: 'no'}) %}
{%-   elif v is none %}
{%-     do opts_to_remove.update({k: v}) %}
{%-   else %}
{%-     do opts.update({k: v|string}) %}
{%-   endif %}
{%- endfor %}

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
    - key_values: {{ opts | yaml }}
    - append_if_not_found: True
    - require:
      - file: sysconfig_netcfg_{{ label | to_snake_case }}_file

{%- if opts_to_remove %}
sysconfig_netcfg_{{ label | to_snake_case }}_opts_removed:
  file.keyvalue:
    - name: /etc/sysconfig/network-scripts/{{ label }}
    - key_values: {{ opts_to_remove | yaml }}
    - count: 0
    - require:
      - file: sysconfig_netcfg_{{ label | to_snake_case }}_file
{%- endif %}

{%- endif %}
{%- endfor %}
