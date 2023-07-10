# OpenTelemetry-C++ ABI check

## Pre requisites

Install abi_dumper

```shell
abi-dumper --version
ABI Dumper 1.3
Copyright (C) 2021 Andrey Ponomarenko's ABI Laboratory
License: GNU LGPL 2.1 <http://www.gnu.org/licenses/>
This program is free software: you can redistribute it and/or modify it.

Written by Andrey Ponomarenko.
```

Install abi-compliance-checker

```shell
abi-compliance-checker --version
ABI Compliance Checker (ABICC) 2.3
Copyright (C) 2019 Andrey Ponomarenko's ABI Laboratory
License: GNU LGPL 2.1 <http://www.gnu.org/licenses/>
This program is free software: you can redistribute it and/or modify it.

Written by Andrey Ponomarenko.
```

Install a GCC C++ compiler, for example

```shell
CXX=/path/to/g++-12
```

## Getting Started

```shell
git submodule init
git submodule sync
```

```
cd abi
```

```shell
./scripts/dump-all.sh
```

```shell
./scripts/check-abi.sh
```

Then inspect reports under `abi/compat_reports/`.

