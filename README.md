# sysconfig-formula

SaltStack formula for managing system settings on SUSE distributions and RHEL/CentOS derivatives.

## Table of Contents

* [Table of Contents](#table-of-contents)
* [General notes](#general-notes)
* [Available states](#available-states)
  * [sysconfig.proxy](#sysconfig.proxy)
  * [sysconfig.network\_scripts](#sysconfig.network\_scripts)

## General notes

See the full [SaltStack Formulas installation and usage instructions](https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html).

This formula has a general *sysconfig* name, but right now its only purpose is
to configure proxy settings and manage network configuration files for SUSE
distributions and other RHEL/CentOS derivatives.

See <code>[pillar.example](pillar.example)</code> file for configuration examples.

## Available states

### sysconfig.proxy

This state manages `/etc/sysconfig/proxy` configuration file.

### sysconfig.network\_scripts

This state manages network configuration files in the `/etc/sysconfig/network-scripts` directory.
