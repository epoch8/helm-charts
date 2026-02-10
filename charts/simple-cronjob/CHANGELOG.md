# 1.0.0

## Breaking changes

* Reverse logic of release `simple-app==0.10.0`: now default names of all
  resources equal to `{.Release.Name}-{.Chart.Name}`

## Changes

* Adapt chart for multi-chart use case with better use of .Values.global
* Extract common helpers to `epoch8-common` subchart

# 0.1.2, 0.1.3

* Remove dummy healtchecks, sometimes they result in Pod being stuck

# 0.1.1

* Fix for PVC creation in case of volumes `secret` and `configMap` types

# 0.1.0

* Initial release