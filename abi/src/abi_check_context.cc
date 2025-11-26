// Copyright The OpenTelemetry Authors
// SPDX-License-Identifier: Apache-2.0

#include "abi_helper.h"

#include <map>

#include "opentelemetry/context/context.h"
#include "opentelemetry/context/context_value.h"

void do_abi_check_context() {
  std::map<std::string, opentelemetry::context::ContextValue> map_test = {
      {"test_key", static_cast<int64_t>(123)},
      {"foo_key", static_cast<int64_t>(456)}};
  const opentelemetry::context::Context test_context =
      opentelemetry::context::Context(map_test);
  int test_value =
      opentelemetry::nostd::get<int64_t>(test_context.GetValue("test_key"));
  int foo_value =
      opentelemetry::nostd::get<int64_t>(test_context.GetValue("foo_key"));
}
