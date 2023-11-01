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

## Adding new ABI tests

An ABI test is a plain C++ file.

The test is a compile time check, not a runtime check,
so the test itself only needs to build: it will never be executed.

Create a new test file, for example

* `abi/src/abi_check_foo.cc`

See file `abi/src/abi_check_TEMPLATE.cc` for instructions.

If a test can only be executed against some versions,
create a version file for the test:

* `abi/src/abi_check_foo.ver`

See file `abi/src/abi_check_TEMPLATE.ver` for instructions.

Last, reference the new test,
by adding a line in file:

* `abi/src/ABI_CHECK_LIST`

## Adding new version to test

A version consist of:

* A name
* A version number
* A directory under api

First, add a new line in file:

* `abi/src/ABI_VERSIONS`

For versions corresponding to an opentelemetry release,
use the release tag as a name, for example `v1.10.0`.

For versions corresponding to a pull request,
use the PR number, for example `pr1234`.

Second, create a directory for the version to test,
that contains all the version source code.

```shell
mkdir api/VERSION_NAME
```

### Adding a git submodule

Clone opentelemetry-cpp and checkout the proper tag

```shell
git submodule add git@github.com:open-telemetry/opentelemetry-cpp.git api/v1.11.0/opentelemetry-cpp
cd api/v1.11.0/opentelemetry-cpp
git checkout v1.11.0
```

Then, add the submodule and commit.

```shell
git add api/v1.11.0/opentelemetry-cpp
```

## Staying up to date with main

The `main` submodule does not keep track of changes in the opentelemetry-cpp
repository.

To update the main version, pull explicitly.

```shell
cd api/main/opentelemetry-cpp
git pull origin main
```
