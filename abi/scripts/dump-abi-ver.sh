#!/bin/bash

# Copyright The OpenTelemetry Authors
# SPDX-License-Identifier: Apache-2.0

set -e

function usage {
  echo "Usage: $(basename $0) " 2>&1
  echo '  -c c++ compiler (g++-12)'
  echo '  -n c++ compiler name (gcc12)'
  echo '  -t test name'
  echo '  -v opentelemetry-cpp version (v1.2.3 or main)'
  exit 1
}

CXX="g++-12"
CXX_NAME="gcc12"
ABI_VERSION="main"

optstring="c:n:t:v:"

while getopts ${optstring} arg; do
  case "${arg}" in
    c) CXX=${OPTARG};;
    n) CXX_NAME=${OPTARG};;
    t) TEST=${OPTARG};;
    v) ABI_VERSION=${OPTARG};;

    ?)
      echo "Invalid option: -${OPTARG}."
      echo
      usage
      ;;
  esac
done

CXX_ABI_FLAGS="-g -Og"

rm -f *.o

# Find the API_VERSION value that matches ABI_VERSION

VERSION_LINE=`grep ${ABI_VERSION} src/ABI_VERSIONS`

# echo ${VERSION_LINE}

API_VERSION_FLAG=`echo ${VERSION_LINE} | cut -f 2 -d" "`

echo "Compiling with -DAPI_CHECK_VERSION=${API_VERSION_FLAG}"

echo "Compiling src/${TEST}.cc with ${CXX_NAME}, version ${ABI_VERSION} ..."

${CXX} ${CXX_ABI_FLAGS} \
-I ../api/${ABI_VERSION}/opentelemetry-cpp/api/include \
-DAPI_CHECK_VERSION=${API_VERSION_FLAG} \
-c src/${TEST}.cc \
-o bin/${TEST}.o

echo "Dumping bin/${TEST}.o for compiler ${CXX_NAME}, version ${ABI_VERSION} ..."
abi-dumper -lver ${ABI_VERSION} bin/${TEST}.o -o bin/${TEST}-${CXX_NAME}-${ABI_VERSION}.dump

