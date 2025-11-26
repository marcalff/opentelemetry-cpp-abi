# abi/compat_reports directory

ABI compatibility reports are generated here.

To inspect the reports:

```
grep -R -l "verdict:compatible" *
```

```
grep -R -l "verdict:incompatible" *
```

Expected, break in v1.1.0:

```
[malff@malff-desktop compat_reports]$ grep -R -l "verdict:incompatible" * | grep "abiv1"
abi_check_trace/abiv1-v1.0.0-nostd_to_abiv1-main-nostd/compat_report.html
```

Expected, abiv2 is not stable and changes:

```
[malff@malff-desktop compat_reports]$ grep -R -l "verdict:incompatible" * | grep "abiv2"
abi_check_metric/abiv2-v1.12.0-nostd_to_abiv2-main-nostd/compat_report.html
abi_check_metric/abiv2-v1.13.0-nostd_to_abiv2-main-nostd/compat_report.html
abi_check_metric/abiv2-v1.14.0-nostd_to_abiv2-main-nostd/compat_report.html
abi_check_metric/abiv2-v1.14.1-nostd_to_abiv2-main-nostd/compat_report.html
abi_check_metric/abiv2-v1.14.2-nostd_to_abiv2-main-nostd/compat_report.html
abi_check_metric/abiv2-v1.15.0-nostd_to_abiv2-main-nostd/compat_report.html
abi_check_metric/abiv2-v1.16.0-nostd_to_abiv2-main-nostd/compat_report.html
abi_check_metric/abiv2-v1.16.1-nostd_to_abiv2-main-nostd/compat_report.html
abi_check_metric/abiv2-v1.17.0-nostd_to_abiv2-main-nostd/compat_report.html
abi_check_metric/abiv2-v1.18.0-nostd_to_abiv2-main-nostd/compat_report.html
abi_check_metric/abiv2-v1.19.0-nostd_to_abiv2-main-nostd/compat_report.html
abi_check_metric/abiv2-v1.20.0-nostd_to_abiv2-main-nostd/compat_report.html
abi_check_metric/abiv2-v1.21.0-nostd_to_abiv2-main-nostd/compat_report.html
abi_check_metric/abiv2-v1.22.0-nostd_to_abiv2-main-nostd/compat_report.html
abi_check_metric/abiv2-v1.23.0-nostd_to_abiv2-main-nostd/compat_report.html
abi_check_trace/abiv2-v1.12.0-nostd_to_abiv2-main-nostd/compat_report.html
abi_check_trace/abiv2-v1.13.0-nostd_to_abiv2-main-nostd/compat_report.html
abi_check_trace/abiv2-v1.14.0-nostd_to_abiv2-main-nostd/compat_report.html
abi_check_trace/abiv2-v1.14.1-nostd_to_abiv2-main-nostd/compat_report.html
abi_check_trace/abiv2-v1.14.2-nostd_to_abiv2-main-nostd/compat_report.html
abi_check_trace/abiv2-v1.15.0-nostd_to_abiv2-main-nostd/compat_report.html
```
