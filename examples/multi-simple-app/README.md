# Multi-Simple-App Example

This example demonstrates how to create a "super-chart" that configures and deploys multiple instances of `simple-app` (or `simple-cronjob`) in a single Helm release.

## Overview

This setup allows applications to be "stacked" easily in a multi-chart scenario. The main goal is to establish a hierarchy of configuration where:

1.  **Global Defaults**: Common values (like container images, registries, or shared environment variables) are defined in the `global` key.
2.  **Local Overrides**: Defaults are respected unless explicitly overridden by a specific application's configuration.

By applying this chart, you create all resources at once and manage them as a single Helm release.

## Configuration Structure

### Chart Definition
In your `Chart.yaml`, you include the base charts (`simple-app`, `simple-cronjob`, etc.) multiple times, assigning a unique `alias` to each instance.

```yaml
dependencies:
  - name: simple-app
    alias: app-one
    # ...
  - name: simple-app
    alias: app-two
    # ...
```

### Values Configuration
In `values.yaml`, you can define global configurations that apply to all subcharts, as well as specific overrides for each alias.

```yaml
global:
  image:
    repository: myregistry/common-backend
    tag: "1.2.3"
  # Common environment variables
  env:
    - name: ENVIRONMENT
      value: production

app-one:
  # Inherits image from global
  replicaCount: 2

app-two:
  # Overrides image tag, inherits repository from global
  image:
    tag: "1.2.4"
```

## Usage

1. Update chart dependencies to pull the subcharts:
   ```bash
   helm dependency update
   ```

2. Render the templates to verify changes:
   ```bash
   helm template .
   ```