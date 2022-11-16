[![CI](https://github.com/bitnami/bncert/actions/workflows/main.yml/badge.svg)](https://github.com/bitnami/bncert/actions/workflows/main.yml)

# Bncert

The Bitnami HTTPS Configuration Tool, also referred to as Bncert, is an interactive command-line tool for configuring HTTPS certificates on Bitnami stacks, as well as common features such as automatic renewals, redirections (e.g. HTTP to HTTPS), etc. This tool is usually located in the installation directory of Bitnami stacks at */opt/bitnami/bncert-tool*.

[Refer to our documentation to learn more about Bncert](https://docs.bitnami.com/general/how-to/understand-bncert/).

# Basic usage

```bash
$ wget -O bncert-linux-x64.run https://downloads.bitnami.com/files/bncert/latest/bncert-linux-x64.run
$ chmod a+x bncert-linux-x64.run
$ sudo ./bncert-linux-x64.run
```
