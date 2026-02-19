# simple-charts-common

Common helper templates for Epoch8 Helm charts.

## Description

This is a Helm library chart that provides reusable helper templates for Epoch8's application charts. Library charts cannot be deployed directly but are included as dependencies in application charts.

## Provided Helpers

### `simple-charts-common.name`
Expands the chart name with support for `.Values.nameOverride`.

### `simple-charts-common.fullname`
Creates a fully qualified name (truncated to 63 characters). Uses `.Values.fullnameOverride` if provided, otherwise combines `Release.Name` with the chart name.

### `simple-charts-common.chart`
Generates the chart name and version label in the format required by `helm.sh/chart`.

### `simple-charts-common.image`
Computes the full image reference by merging global and local image settings. Supports cascading defaults: local → global.

### `simple-charts-common.labels`
Standard Kubernetes labels including chart, version, selector labels, and managed-by.

### `simple-charts-common.selectorLabels`
Pod selector labels (`app.kubernetes.io/name` and `app.kubernetes.io/instance`).

### `simple-charts-common.serviceAccount.create`
Boolean logic for service account creation. Returns "true" or empty string based on local → global → default true.

### `simple-charts-common.serviceAccountName`
Resolves the service account name based on whether a service account should be created.

### `simple-charts-common.env`
Outputs environment variables from merged global and local values.

## Usage

Add as a dependency in your Chart.yaml:

```yaml
dependencies:
  - name: simple-charts-common
    version: "^0.1.0"
    repository: "file://../simple-charts-common"
```

Then use the helpers in your templates:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "simple-charts-common.fullname" . }}
  labels:
    {{- include "simple-charts-common.labels" . | nindent 4 }}
spec:
  selector:
    matchLabels:
      {{- include "simple-charts-common.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      labels:
        {{- include "simple-charts-common.selectorLabels" . | nindent 8 }}
    spec:
      containers:
      - name: {{ include "simple-charts-common.name" . }}
        image: {{ include "simple-charts-common.image" . }}
        {{- include "simple-charts-common.env" . | nindent 8 }}
```

## Requirements

Charts using this library must have the following values structure:

```yaml
global:
  image:
    repository: ""
    tag: ""
  env: []
  serviceAccount:
    create: true
    name: ""

image:
  repository: ""
  tag: ""

nameOverride: ""
fullnameOverride: ""

env: []

serviceAccount:
  create: null
  name: ""
```

## Version

Current version: 0.1.0
