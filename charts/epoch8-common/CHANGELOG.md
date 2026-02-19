# 0.4.0

- Add `extraEnv` support in `epoch8-common.env` helper: extra environment
  variables are now appended to the base env (from `env` or `global.env`) rather
  than replacing it

# 0.3.0

* Add `epoch8-common.configChecksumAnnotations` helper for automatic pod
  restarts when ConfigMap changes
* Add `epoch8-common.podAnnotations` helper for centralized pod annotations
  generation
* Enables rolling updates when `.Values.configs` content changes
* Can be disabled with `autoRestartOnConfigChange: false`

# 0.2.0

* Add `epoch8-common.hostAliases` helper for managing Pod hostAliases with
  global and local override support

# 0.1.0

* Initial release with common helper templates
* Helpers: name, fullname, chart, image, labels, selectorLabels,
  serviceAccount.create, serviceAccountName, env
