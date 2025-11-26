#!/bin/bash

# Copyright The OpenTelemetry Authors
# SPDX-License-Identifier: Apache-2.0

set -e

function usage {
  echo "Usage: $(basename $0) " 2>&1
  echo '  -c c++ compiler (g++-12)'
  echo '  -n c++ compiler name (gcc12)'
  echo '  -t test name'
  echo '  -a abi version (abiv1)'
  echo '  -v opentelemetry-cpp version (v1.2.3 or main)'
  exit 1
}

CXX="g++-12"
CXX_NAME="gcc12"
ABI_VERSION="abiv1"
RELEASE_VERSION="main"

optstring="c:n:t:a:v:"

while getopts ${optstring} arg; do
  case "${arg}" in
    c) CXX=${OPTARG};;
    n) CXX_NAME=${OPTARG};;
    t) TEST=${OPTARG};;
    a) ABI_VERSION=${OPTARG};;
    v) RELEASE_VERSION=${OPTARG};;

    ?)
      echo "Invalid option: -${OPTARG}."
      echo
      usage
      ;;
  esac
done

CXX_ABI_FLAGS="-g -Og"

if [[ ${ABI_VERSION} == "abiv2" ]]; then
  CXX_ABI_FLAGS="${CXX_ABI_FLAGS} -DOPENTELEMETRY_ABI_VERSION_NO=2"
fi

echo "CXX_ABI_FLAGS=${CXX_ABI_FLAGS}"

rm -f *.o

# Find the API_VERSION value that matches RELEASE_VERSION

VERSION_LINE=`grep ${RELEASE_VERSION} src/ABI_VERSIONS`

# echo ${VERSION_LINE}

API_VERSION_FLAG=`echo ${VERSION_LINE} | cut -f 3 -d" "`

echo "Compiling with -DAPI_CHECK_VERSION=${API_VERSION_FLAG}"

ABI_FLAVOR="nostd"
ABI_FLAVOR_FLAGS=""
echo "Building abi ${ABI_VERSION} flavor ${ABI_FLAVOR} with flags ${ABI_FLAVOR_FLAGS}"

echo "Compiling src/${TEST}.cc with ${CXX_NAME}, abi ${ABI_VERSION}, version ${RELEASE_VERSION}, flavor ${ABI_FLAVOR} ..."

${CXX} ${CXX_ABI_FLAGS} ${ABI_FLAVOR_FLAGS} \
-I ../api/${RELEASE_VERSION}/opentelemetry-cpp/api/include \
-DAPI_CHECK_VERSION=${API_VERSION_FLAG} \
-c src/${TEST}.cc \
-o bin/${TEST}-${ABI_VERSION}-${RELEASE_VERSION}-${ABI_FLAVOR}.o

echo "Dumping bin/${TEST}.o for compiler ${CXX_NAME}, abi ${ABI_VERSION}, version ${RELEASE_VERSION}, flavor ${ABI_FLAVOR} ..."
abi-dumper -lver ${ABI_VERSION}-${RELEASE_VERSION}-${ABI_FLAVOR} \
bin/${TEST}-${ABI_VERSION}-${RELEASE_VERSION}-${ABI_FLAVOR}.o \
-o bin/${TEST}-${CXX_NAME}-${ABI_VERSION}-${RELEASE_VERSION}-${ABI_FLAVOR}.dump

#
# Work in progress:
# Testing other abi flavor is for later
#

# ABI_FLAVOR="stl"
# ABI_FLAVOR_FLAGS="-DHAVE_CPP_STDLIB -DOPENTELEMETRY_OPTION_USE_STD_SPAN=0"
# echo "Building flavor ${ABI_FLAVOR} with flags ${ABI_FLAVOR_FLAGS}"
#
# echo "Compiling src/${TEST}.cc with ${CXX_NAME}, version ${RELEASE_VERSION}, flavor ${ABI_FLAVOR} ..."
#
# ${CXX} ${CXX_ABI_FLAGS} ${ABI_FLAVOR_FLAGS} \
# -I ../api/${RELEASE_VERSION}/opentelemetry-cpp/api/include \
# -DAPI_CHECK_VERSION=${API_VERSION_FLAG} \
# -c src/${TEST}.cc \
# -o bin/${TEST}-${RELEASE_VERSION}-${ABI_FLAVOR}.o
#
# echo "Dumping bin/${TEST}.o for compiler ${CXX_NAME}, version ${RELEASE_VERSION}, flavor ${ABI_FLAVOR} ..."
# abi-dumper -lver ${RELEASE_VERSION}-${ABI_FLAVOR} \
# bin/${TEST}-${RELEASE_VERSION}-${ABI_FLAVOR}.o \
# -o bin/${TEST}-${CXX_NAME}-${RELEASE_VERSION}-${ABI_FLAVOR}.dump

