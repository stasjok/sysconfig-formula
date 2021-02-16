{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import sysconfig with context %}

sysconfig-proxy-managed:
  file.managed:
    - name: {{ sysconfig.proxy.config }}
    - source: salt://sysconfig/files/proxy
    - user: root
    - group: root
    - mode: 644
    - makedirs: yes
    - template: jinja
    - context:
        proxy: {{ sysconfig.proxy|yaml }}
