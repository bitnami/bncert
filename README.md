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

## License

Copyright &copy; 2023 Bitnami

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
