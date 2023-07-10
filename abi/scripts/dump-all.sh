#!/bin/bash

# Copyright The OpenTelemetry Authors
# SPDX-License-Identifier: Apache-2.0

set -e

function usage {
  echo "Usage: $(basename $0) " 2>&1
  echo '  -c c++ compiler (g++-12)'
  echo '  -n c++ compiler name (gcc12)'
  exit 1
}

CXX="g++-12"
CXX_NAME="gcc12"

optstring="c:n:"

while getopts ${optstring} arg; do
  case "${arg}" in
    c) CXX=${OPTARG};;
    n) CXX_NAME=${OPTARG};;

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

echo "=== Processing TEST ${TEST} ==="
scripts/dump-abi.sh -c ${CXX} -n ${CXX_NAME} -t ${TEST}
echo ""

done

rm bin/ABI_CHECK_LIST.tmp

