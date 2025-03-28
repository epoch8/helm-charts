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
