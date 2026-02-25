# 1.3.1

* Fix ServiceAccount being recreated on every upgrade — hook changed from
  `pre-install,pre-upgrade` to `pre-install`, preserving external annotations
  (e.g. IRSA, Workload Identity)

# 1.3.0

* Add `extraEnv` for appending extra environment variables to the base env
  (`env` or `global.env`)
* Update simple-charts-common dependency to 0.4.0


# 1.2.0

* Add automatic pod restart when ConfigMap changes via
  `simple-charts-common.podAnnotations` helper
* Pods now automatically restart on `configs` value changes (can be disabled
  with `autoRestartOnConfigChange: false`)
* Centralize pod annotations generation in `simple-charts-common.podAnnotations`
  helper
* Update simple-charts-common dependency to 0.3.0

# 1.1.0

* Add support for `hostAliases` configuration with global and local override
  support
* Update simple-charts-common dependency to 0.2.0

# 1.0.0

## Breaking changes

* Reverse logic of release `simple-app==0.10.0`: now default names of all
  resources equal to `{.Release.Name}-{.Chart.Name}`

## Changes

* Adapt chart for multi-chart use case with better use of .Values.global
* Extract common helpers to `simple-charts-common` subchart

# 0.1.5

* Fix for PVC creation in case of volumes `secret` and `configMap` types

# 0.1.4

* Synchonize volumes configuration between simple-app and simple-worker

# 0.1.3

* Synchronize fullname generation between simple-app and simple-worker

# 0.1.2

* Name container the same as release (helps to read logs in GCP)

# 0.1.1

* Add option to mount existing secrets and config maps as volume

# 0.1.0

* Initial release