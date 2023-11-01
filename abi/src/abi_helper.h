// Copyright The OpenTelemetry Authors
// SPDX-License-Identifier: Apache-2.0

/*
  The calling script sets:
  #define API_CHECK_VERSION=MMmmpp
  to give some context.

  Based on this context, this helper makes adjustments,
  so that code for a given test can build in all versions.
*/

#include "opentelemetry/version.h"

/*
  Added only in 1.8.3:
  - OPENTELEMETRY_VERSION_MAJOR
  - OPENTELEMETRY_VERSION_MINOR
  - OPENTELEMETRY_VERSION_PATCH
*/

#if API_CHECK_VERSION < 10803
#define OPENTELEMETRY_VERSION_MAJOR 1
#endif

#if API_CHECK_VERSION == 10000
#define OPENTELEMETRY_VERSION_MINOR 0
#define OPENTELEMETRY_VERSION_PATCH 0
#endif

#if API_CHECK_VERSION == 10100
#define OPENTELEMETRY_VERSION_MINOR 1
#define OPENTELEMETRY_VERSION_PATCH 0
#endif

#if API_CHECK_VERSION == 10200
#define OPENTELEMETRY_VERSION_MINOR 2
#define OPENTELEMETRY_VERSION_PATCH 0
#endif

#if API_CHECK_VERSION == 10300
#define OPENTELEMETRY_VERSION_MINOR 3
#define OPENTELEMETRY_VERSION_PATCH 0
#endif

#if API_CHECK_VERSION == 10400
#define OPENTELEMETRY_VERSION_MINOR 4
#define OPENTELEMETRY_VERSION_PATCH 0
#endif

#if API_CHECK_VERSION == 10500
#define OPENTELEMETRY_VERSION_MINOR 5
#define OPENTELEMETRY_VERSION_PATCH 0
#endif

#if API_CHECK_VERSION == 10600
#define OPENTELEMETRY_VERSION_MINOR 6
#define OPENTELEMETRY_VERSION_PATCH 0
#endif

#if API_CHECK_VERSION == 10700
#define OPENTELEMETRY_VERSION_MINOR 7
#define OPENTELEMETRY_VERSION_PATCH 0
#endif

#if API_CHECK_VERSION == 10800
#define OPENTELEMETRY_VERSION_MINOR 8
#define OPENTELEMETRY_VERSION_PATCH 0
#endif


#ifndef OPENTELEMETRY_VERSION_MAJOR
#error "Unknown major version"
#endif

#ifndef OPENTELEMETRY_VERSION_MINOR
#error "Unknown minor version"
#endif

#ifndef OPENTELEMETRY_VERSION_PATCH
#error "Unknown patch version"
#endif
