#!/bin/bash

# Copyright The OpenTelemetry Authors
# SPDX-License-Identifier: Apache-2.0

# set -e

function usage {
  echo "Usage: $(basename $0) " 2>&1
  echo '   -n c++ compiler name (gcc12)'
  echo '   -v opentelemetry-cpp version (v1.2.3 or main)'
  exit 1
}

CXX_NAME="gcc12"
ABI_VERSION="main"

optstring="n:v:"

while getopts ${optstring} arg; do
  case "${arg}" in
    n) CXX_NAME=${OPTARG};;
    v) ABI_VERSION=${OPTARG};;

    ?)
      echo "Invalid option: -${OPTARG}."
      echo
      usage
      ;;
  esac
done

grep -v "^#" src/ABI_CHECK_LIST | grep -v "^[[:space:]]*$" > bin/ABI_CHECK_LIST.tmp

for TEST in `cat bin/ABI_CHECK_LIST.tmp`
do

echo "Checking compliance for test ${TEST}, compiler ${CXX_NAME}, version ${ABI_VERSION} ..."

export NEW_DUMP=bin/${TEST}-${CXX_NAME}-${ABI_VERSION}.dump

for OLD_DUMP in `ls -1 bin/${TEST}-${CXX_NAME}-*.dump`
do
  abi-compliance-checker -l ${TEST} --old ${OLD_DUMP} --new ${NEW_DUMP}
done

done

rm bin/ABI_CHECK_LIST.tmp

