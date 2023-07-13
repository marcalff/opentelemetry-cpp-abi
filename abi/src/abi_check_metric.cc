// Copyright The OpenTelemetry Authors
// SPDX-License-Identifier: Apache-2.0

#include "abi_helper.h"

#include "opentelemetry/metrics/provider.h"
#include "opentelemetry/metrics/meter_provider.h"

void do_abi_check_metric() {
  auto p = opentelemetry::metrics::Provider::GetMeterProvider();
  auto meter = p->GetMeter("abi");
}
