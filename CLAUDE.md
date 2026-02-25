# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a collection of Helm charts published at `https://epoch8.github.io/helm-charts/`. The charts are organized under `charts/` and an `examples/` directory.

## Charts

- **simple-charts-common** — A Helm *library* chart (type: library) providing shared helper templates used by all other "simple-*" charts. Cannot be deployed directly.
- **simple-app** — General-purpose web application chart (Deployment + Service + optional Ingress/Gateway).
- **simple-worker** — Background worker chart (Deployment, no Service/Ingress).
- **simple-cronjob** — Scheduled job chart (CronJob resource).
- **cvat**, **dash-app**, **datapipe**, **label-studio**, **metabase**, **prefect-agent**, **rasa-bot** — Application-specific charts.

## Testing

Tests use the [helm-unittest](https://github.com/helm-unittest/helm-unittest) plugin. Each testable chart has a `Makefile`:

```bash
# Install the plugin (once)
helm plugin install https://github.com/helm-unittest/helm-unittest.git

# Run tests for a specific chart
cd charts/simple-app && make test
# equivalent to:
helm unittest charts/simple-app

# Run tests for all simple-* charts
for chart in charts/simple-app charts/simple-worker charts/simple-cronjob; do helm unittest $chart; done
```

Test files live in `charts/<name>/tests/` as `*_test.yaml` with supporting `*-values.yaml` fixture files. Snapshots are stored in `tests/__snapshot__/`.

## Architecture: simple-charts-common Library

All `simple-*` charts declare `simple-charts-common` as a local file dependency in `Chart.yaml`:

```yaml
dependencies:
  - name: simple-charts-common
    version: "0.4.0"
    repository: "file://../simple-charts-common"
```

Run `helm dependency update` inside a chart directory after changing the library or its version.

The library (`charts/simple-charts-common/templates/_helpers.tpl`) provides these named templates:
- `simple-charts-common.fullname` / `simple-charts-common.name` — resource naming with override support
- `simple-charts-common.image` — resolves image from local `image.*` falling back to `global.image.*`
- `simple-charts-common.labels` / `simple-charts-common.selectorLabels` — standard k8s labels
- `simple-charts-common.serviceAccount.create` / `simple-charts-common.serviceAccountName` — SA logic with local→global→default(true) precedence
- `simple-charts-common.env` — merges `env` (local overrides `global.env`) + appends `extraEnv`
- `simple-charts-common.hostAliases` — merges local/global host aliases
- `simple-charts-common.podAnnotations` — combines `podAnnotations` with config checksum for auto-restart
- `simple-charts-common.configChecksumAnnotations` — SHA256 checksum of `configs` values to trigger rolling updates when configs change

## Key Values Patterns

**Environment variables** (`env`/`extraEnv`/`global.env`):
- `env` overrides `global.env` entirely
- `extraEnv` is always appended to whichever base env is used

**Image resolution**: local `image.repository`/`image.tag` → falls back to `global.image.repository`/`global.image.tag`

**Volumes** in `simple-app`/`simple-worker` use a unified `volumes` list where the volume type is inferred:
- Has `hostPath` → HostPath mount (no resource created)
- Has `size` + `emptyDir: true` → EmptyDir
- Has `size` (no emptyDir) → PVC created automatically
- Has `secret` → SecretVolumeSource
- Has `configMap` → ConfigMapVolumeSource

**Auto-restart on config change**: When `configs` is set, a `checksum/configs` annotation is added to pods. Disable with `autoRestartOnConfigChange: false`.

**Deployment strategy**: Automatically uses `Recreate` when volumes with PVCs are mounted (non-emptyDir, non-secret, non-configMap); otherwise uses `RollingUpdate`.

## Multi-Chart (Umbrella) Pattern

See `examples/multi-simple-app/` for how to compose multiple `simple-app`/`simple-cronjob` instances in one Helm release using `alias` in `Chart.yaml` and top-level keys in `values.yaml` matching the aliases.

## Template Rendering / Linting

```bash
# Render templates to check output
helm template . --values my-values.yaml

# Lint a chart
helm lint charts/simple-app
```
