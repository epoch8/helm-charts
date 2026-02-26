{{/*
Expand the name of the chart.
*/}}
{{- define "simple-charts-common.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "simple-charts-common.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- if .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end -}}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "simple-charts-common.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Compute image based on global values and image specific values
*/}}
{{- define "simple-charts-common.image" -}}
{{- $image := .Values.image -}}
{{- $global := .Values.global.image | default dict -}}
{{- $imageName := $image.repository | default $global.repository -}}
{{- $imageTag := $image.tag | default $global.tag -}}
{{- printf "%s:%s" $imageName $imageTag | trimSuffix ":" }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "simple-charts-common.labels" -}}
helm.sh/chart: {{ include "simple-charts-common.chart" . }}
{{ include "simple-charts-common.selectorLabels" . }}
app.kubernetes.io/version: {{ (.Values.image | default dict).tag | default (.Values.global.image | default dict).tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "simple-charts-common.selectorLabels" -}}
app.kubernetes.io/name: {{ include "simple-charts-common.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Should the service account be created

If local serviceAccount.create is set, use it
Else if global.serviceAccount.create is set, use it
Else default to true

Returns empty string if false, "true" if true
*/}}
{{- define "simple-charts-common.serviceAccount.create" -}}
{{- $localCreate := .Values.serviceAccount.create -}}
{{- $globalCreate := (.Values.global.serviceAccount | default dict).create -}}
{{- if ne $localCreate nil -}}
{{- if $localCreate -}}true{{- end -}}
{{- else if ne $globalCreate nil -}}
{{- if $globalCreate -}}true{{- end -}}
{{- else -}}
true
{{- end -}}
{{- end }}


{{/*
Name of the service account to use

If "simple-charts-common.serviceAccount.create" is true, use:
    .Values.serviceAccount.name or .Values.global.serviceAccount.name or include "simple-charts-common.fullname"
If "simple-charts-common.serviceAccount.create" is false, use:
    .Values.serviceAccount.name or .Values.global.serviceAccount.name or "default"
*/}}
{{- define "simple-charts-common.serviceAccountName" -}}
{{- $globalSA := .Values.global.serviceAccount | default dict -}}
{{- if include "simple-charts-common.serviceAccount.create" . -}}
{{- .Values.serviceAccount.name | default $globalSA.name | default (include "simple-charts-common.fullname" .) -}}
{{- else -}}
{{- .Values.serviceAccount.name | default $globalSA.name | default "default" -}}
{{- end -}}
{{- end }}


{{/*
Compute environment variables from global and local values.
- .Values.env overrides .Values.global.env (use one or the other)
- .Values.extraEnv is always appended to the base env (global or local)
*/}}
{{- define "simple-charts-common.env" -}}
{{- $baseEnv := .Values.env | default .Values.global.env | default list }}
{{- $extraEnv := .Values.extraEnv | default list }}
{{- $allEnv := concat $baseEnv $extraEnv }}
{{- if $allEnv }}
env:
    {{- $allEnv | toYaml | nindent 2 }}
{{- end }}
{{- end }}


{{/*
Compute hostAliases from global and local values
*/}}
{{- define "simple-charts-common.hostAliases" -}}
{{- if .Values.hostAliases | default .Values.global.hostAliases }}
hostAliases:
  {{- .Values.hostAliases | default .Values.global.hostAliases | toYaml | nindent 2 }}
{{- end }}
{{- end }}


{{/*
Generate checksum annotations for pod restarts on config changes.
Creates a SHA256 checksum of the configs values to trigger rolling updates
when config content changes.
*/}}
{{- define "simple-charts-common.configChecksumAnnotations" -}}
{{- if .Values.configs }}
{{- if not (hasKey .Values "autoRestartOnConfigChange") | or .Values.autoRestartOnConfigChange }}
checksum/configs: {{ toYaml .Values.configs | sha256sum }}
{{- end }}
{{- end }}
{{- end }}


{{/*
Compute resources from global and local values.
*/}}
{{- define "simple-charts-common.resources" -}}
{{- $r := .Values.resources | default .Values.global.resources | default dict }}
resources:
  {{- toYaml $r | nindent 2 }}
{{- end }}


{{/*
Compute imagePullSecrets from global and local values.
*/}}
{{- define "simple-charts-common.imagePullSecrets" -}}
{{- with (.Values.imagePullSecrets | default .Values.global.imagePullSecrets) }}
imagePullSecrets:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}


{{/*
Compute nodeSelector from global and local values.
*/}}
{{- define "simple-charts-common.nodeSelector" -}}
{{- with (.Values.nodeSelector | default .Values.global.nodeSelector) }}
nodeSelector:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}


{{/*
Compute tolerations from global and local values.
*/}}
{{- define "simple-charts-common.tolerations" -}}
{{- with (.Values.tolerations | default .Values.global.tolerations) }}
tolerations:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}


{{/*
Compute affinity from global and local values.
*/}}
{{- define "simple-charts-common.affinity" -}}
{{- with (.Values.affinity | default .Values.global.affinity) }}
affinity:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}


{{/*
Generate all pod annotations including checksums and user-provided annotations.
Outputs the complete annotations block only if there are annotations to add.
Usage: {{- include "simple-charts-common.podAnnotations" . | nindent <spaces> }}
*/}}
{{- define "simple-charts-common.podAnnotations" -}}
{{- $checksumAnnotations := include "simple-charts-common.configChecksumAnnotations" . -}}
{{- if or $checksumAnnotations .Values.podAnnotations -}}
annotations:
  {{- if $checksumAnnotations }}
  {{- $checksumAnnotations | nindent 2 }}
  {{- end }}
  {{- with .Values.podAnnotations }}
  {{- toYaml . | nindent 2 }}
  {{- end }}
{{- end }}
{{- end }}
