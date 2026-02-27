# 1.4.2

* Allow extra/unknown values (e.g. `enabled`) without schema validation errors

# 1.4.1

* Update simple-charts-common to 0.5.1 (fix nil-safe `.Values.image` in labels)

# 1.4.0

* Add global fallback support for umbrella-chart use cases — the following
  properties can now be defined in `global` and serve as defaults for all
  sub-charts: `port`, `servicePort`, `probe`, `livenessProbe`, `readinessProbe`,
  `replicaCount`, `autoscaling`, `resources`, `ingress`, `monitoringCoreos`,
  `nodeSelector`, `tolerations`, `affinity`, `imagePullSecrets`
* `initJob` now inherits `resources` from the app (falling back to
  `global.resources`) when `initJob.resources` is not set
* Update simple-charts-common dependency to 0.5.0

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

# 0.19.0

* Add `terminationGracePeriodSeconds` parameter for pod termination grace period

# 0.18.0

* Add `autoscaling.customMetrics` and `autoscaling.behavior` for HPA

# 0.17.1

* Remove successful init jobs

# 0.17.0

* Add `.workingDir` to root configuration and `.initJob`

# 0.16.1

* Fixed bug when creating serviceaccount if `.initJob` hook is enabled

# 0.16.0

* Add `.volumes[].hostPath` property to mount volume as a hostPath type

# 0.15.2

* Switch `.initJob` hook from `post-upgrade` to `pre-upgrade`

# 0.15.0, 0.15.1

* Add `.initJob` to run Job after install or upgrade

# 0.14.0

* Add `monitoringCoreos.port` for case when monitoring endpoint is on a
  different port

# 0.13.0

* Add `spreadServiceAcrossNodes` setting

# 0.12.0, 0.12.1

* Add `monitoringCoreos` setting for prometheus-operator managed metrics
  collection

# 0.11.10

* Add ability to specify `namespace` for Gateway reference in HTTPRoute

# 0.11.9

* Do `RollingUpdate` unless we really need to do `Recreate`

# 0.11.8

* Fix for PVC creation in case of volumes `secret` and `configMap` types

# 0.11.7

* Fix HPA for `autoscaling/v2` syntax

# 0.11.6

* Update HPA `apiVersion`: `autoscaling/v2beta1` -> `autoscaling/v2`

# 0.11.5

* Add support for `monitoring.googleapis.com/v1` `PodMonitoring`

# 0.11.4

* Add `.volumes[].secret` and `.volumes[].configMap` options

# 0.11.3

* Add GCP IAP configuation for `GCPBackendPolicy`

# 0.11.2

* Name container the same as release (helps to read logs in GCP)

# 0.11.1

* Add GKE-specific `GCPBackendPolicy` resource based on `.Values.timeoutSec`

# 0.11.0

* Restore `.Values.probe`
* Add GKE-specific `HealthCheck` resource based on `.Values.probe.path`

## Backwards incompatibility

* `livenessProbe` and `readinessProbe` defaults changed

# 0.10.6

* Add support for Gateway/HTTPRoute
  https://cloud.google.com/kubernetes-engine/docs/concepts/gateway-api

# 0.10.5

* Add `.volumes[*].emptyDir`

# 0.10.4

* Add `.configs[*].mountPath`

# 0.10.0

## Backwards incompatibility

* Default names for all resources equal to release name
* Delete `.Values.probe`. `livenessProbe` and `readinessProbe` import from values file
* Rename `.service.port` -> `.servicePort`, `.service.type` -> `.serviceType`
* Rename `.servicePorts` -> `.extraPorts`
* Add `.extraPorts[*].servicePort` config

# 0.9.1

* Add support for `.initialDelaySeconds` in `livenessProbe` and `readinessProbe`

# 0.9.0

* Add `.servicePorts`

## Backwards incompatibility

* Add `.livenessProbe.enabled`
* Add `.readinessProbe.enabled`

# 0.8.0

* Add `.shmSize`

# 0.7.0

* Add `Ingress` `className` property

# 0.5.1

* Set deploy strategy to Recreate if PVC is enabled

# 0.5.0

* Support for PVC
