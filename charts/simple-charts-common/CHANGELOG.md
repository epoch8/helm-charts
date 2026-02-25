# 0.5.0

* Add `simple-charts-common.resources` helper: resolves resources from local
  `resources` falling back to `global.resources`
* Add `simple-charts-common.imagePullSecrets` helper: resolves imagePullSecrets
  from local falling back to `global.imagePullSecrets`
* Add `simple-charts-common.nodeSelector` helper: resolves nodeSelector from
  local falling back to `global.nodeSelector`
* Add `simple-charts-common.tolerations` helper: resolves tolerations from
  local falling back to `global.tolerations`
* Add `simple-charts-common.affinity` helper: resolves affinity from local
  falling back to `global.affinity`
* All helpers are now nil-safe when `global` is unset

# 0.4.0

- Add `extraEnv` support in `simple-charts-common.env` helper: extra environment
  variables are now appended to the base env (from `env` or `global.env`) rather
  than replacing it

# 0.3.0

* Add `simple-charts-common.configChecksumAnnotations` helper for automatic pod
  restarts when ConfigMap changes
* Add `simple-charts-common.podAnnotations` helper for centralized pod annotations
  generation
* Enables rolling updates when `.Values.configs` content changes
* Can be disabled with `autoRestartOnConfigChange: false`

# 0.2.0

* Add `simple-charts-common.hostAliases` helper for managing Pod hostAliases with
  global and local override support

# 0.1.0

* Initial release with common helper templates
* Helpers: name, fullname, chart, image, labels, selectorLabels,
  serviceAccount.create, serviceAccountName, env
