# 1.0.0

## Backwards incompatibility

* Default names for all resources equal to release name
* Delete `Values.probe`. `livenessProbe` and `readinessProbe` import from values file

# 0.9.1

* Add support for `.initialDelaySeconds` in `livenessProbe` and `readinessProbe`

# 0.9.0

* Add `.servicePorts`

## Backwards incompatibility

* Add `.livenessProbe.enabled`
* Add `.readinessProbe.enabled`

# 0.8.0

* Add `.shmSize` to 

# 0.7.0

* Add `Ingress` `className` property

# 0.5.1

* Set deploy strategy to Recreate if PVC is enabled

# 0.5.0

* Support for PVC
