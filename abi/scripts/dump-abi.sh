#!/bin/bash

# Copyright The OpenTelemetry Authors
# SPDX-License-Identifier: Apache-2.0

set -e

function usage {
  echo "Usage: $(basename $0) " 2>&1
  echo '  -c c++ compiler (g++-12)'
  echo '  -n c++ compiler name (gcc12)'
  echo '  -t test name'
  exit 1
}

CXX="g++-12"
CXX_NAME="gcc12"

optstring="c:n:t:"

while getopts ${optstring} arg; do
  case "${arg}" in
    c) CXX=${OPTARG};;
    n) CXX_NAME=${OPTARG};;
    t) TEST=${OPTARG};;

    ?)
      echo "Invalid option: -${OPTARG}."
      echo
      usage
      ;;
  esac
done

grep -v "^#" src/${TEST}.ver | grep -v "^[[:space:]]*$" > bin/${TEST}.tmp

for ABI_VERSION in `cat bin/${TEST}.tmp`
do
echo "--- Processing ABI_VERSION ${ABI_VERSION} ---"
scripts/dump-abi-ver.sh -c ${CXX} -n ${CXX_NAME} -t ${TEST} -v ${ABI_VERSION}
echo ""

done

rm bin/${TEST}.tmp

