# 1.0.0

## Breaking changes

* Reverse logic of release `simple-app==0.10.0`: now default names of all
  resources equal to `{.Release.Name}-{.Chart.Name}`

## Changes

* Adapt chart for multi-chart use case with better use of .Values.global

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