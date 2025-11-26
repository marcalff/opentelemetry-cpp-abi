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

COMMENT_REGEXP="^#.*$"
EMPTY_REGEXP="^[[:space:]]*$"
MIN_VERSION_NUMBER_REGEXP="^MIN_VERSION_NUMBER=[0-9]*$"
MAX_VERSION_NUMBER_REGEXP="^MAX_VERSION_NUMBER=[0-9]*$"

# If it exists, scan the src/{TEST}.ver file for version ranges.

MIN_VERSION_NUMBER=0
MAX_VERSION_NUMBER=0

if [[ -f src/${TEST}.ver ]]; then

  echo "Scanning file src/${TEST}.ver"

  while IFS= read -r line; do
    # printf '%s\n' "$line"
    if [[ ${line} =~ ${MIN_VERSION_NUMBER_REGEXP} ]]; then
      MIN_VERSION_NUMBER=`echo ${line} | cut -f 2 -d"="`
      echo "Found MIN_VERSION_NUMBER=${MIN_VERSION_NUMBER}"
      continue;
    fi
    if [[ ${line} =~ ${MAX_VERSION_NUMBER_REGEXP} ]]; then
      MAX_VERSION_NUMBER=`echo ${line} | cut -f 2 -d"="`
      echo "Found MAX_VERSION_NUMBER=${MIN_VERSION_NUMBER}"
      continue;
    fi

  done < src/${TEST}.ver
fi

echo "Version range ${MIN_VERSION_NUMBER} - ${MAX_VERSION_NUMBER}"

# Scan the src/ABI_VERSIONS file

while IFS= read -r line; do
  # printf '%s\n' "$line"
  if [[ ${line} =~ ${COMMENT_REGEXP} ]]; then
    continue;
  fi
  if [[ ${line} =~ ${EMPTY_REGEXP} ]]; then
    continue;
  fi
  ABI_VERSION=`echo ${line} | cut -f 1 -d" "`
  RELEASE_VERSION=`echo ${line} | cut -f 2 -d" "`
  RELEASE_VERSION_NUMBER=`echo ${line} | cut -f 3 -d" "`

  # Only process relevant versions

  if [[ ${MIN_VERSION_NUMBER} != 0 && ${MIN_VERSION_NUMBER} > ${RELEASE_VERSION_NUMBER} ]]; then
    echo "--- Excluding RELEASE_VERSION ${RELEASE_VERSION} ---"
    continue;
  fi

  if [[ ${MAX_VERSION_NUMBER} != 0 && ${MAX_VERSION_NUMBER} < ${RELEASE_VERSION_NUMBER} ]]; then
    echo "--- Excluding RELEASE_VERSION ${RELEASE_VERSION} ---"
    continue;
  fi

  echo "--- Processing ABI_VERSION ${ABI_VERSION} RELEASE_VERSION ${RELEASE_VERSION} ---"
  scripts/dump-abi-ver.sh -c ${CXX} -n ${CXX_NAME} -t ${TEST} -a ${ABI_VERSION} -v ${RELEASE_VERSION}
done < src/ABI_VERSIONS

