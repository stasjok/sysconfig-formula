# sysconfig-formula

SaltStack formula for managing system proxy settings on SUSE distributions.

## Table of Contents

* [Table of Contents](#table-of-contents)
* [General notes](#general-notes)
* [Available states](#available-states)
  * [sysconfig.proxy](#sysconfig.proxy)

## General notes

See the full [SaltStack Formulas installation and usage instructions](https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html).

This formula has a general *sysconfig* name, but right now its only purpose is
to configure proxy settings for SUSE distributions.

See `pillar.example` file for configuration examples.

## Available states

### sysconfig.proxy

This state manages `/etc/sysconfig/proxy` configuration file.
