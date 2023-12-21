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
