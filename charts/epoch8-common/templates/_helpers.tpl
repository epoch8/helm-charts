{{/*
Expand the name of the chart.
*/}}
{{- define "epoch8-common.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "epoch8-common.fullname" -}}
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
{{- define "epoch8-common.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Compute image based on global values and image specific values
*/}}
{{- define "epoch8-common.image" -}}
{{- $image := .Values.image -}}
{{- $global := .Values.global.image -}}
{{- $imageName := $image.repository | default $global.repository -}}
{{- $imageTag := $image.tag | default $global.tag -}}
{{- printf "%s:%s" $imageName $imageTag | trimSuffix ":" }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "epoch8-common.labels" -}}
helm.sh/chart: {{ include "epoch8-common.chart" . }}
{{ include "epoch8-common.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | default .Values.global.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "epoch8-common.selectorLabels" -}}
app.kubernetes.io/name: {{ include "epoch8-common.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Should the service account be created

If local serviceAccount.create is set, use it
Else if global.serviceAccount.create is set, use it
Else default to true

Returns empty string if false, "true" if true
*/}}
{{- define "epoch8-common.serviceAccount.create" -}}
{{- $localCreate := .Values.serviceAccount.create -}}
{{- $globalCreate := .Values.global.serviceAccount.create -}}
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

If "epoch8-common.serviceAccount.create" is true, use:
    .Values.serviceAccount.name or .Values.global.serviceAccount.name or include "epoch8-common.fullname"
If "epoch8-common.serviceAccount.create" is false, use:
    .Values.serviceAccount.name or .Values.global.serviceAccount.name or "default"
*/}}
{{- define "epoch8-common.serviceAccountName" -}}
{{- if include "epoch8-common.serviceAccount.create" . -}}
{{- .Values.serviceAccount.name | default .Values.global.serviceAccount.name | default (include "epoch8-common.fullname" .) -}}
{{- else -}}
{{- .Values.serviceAccount.name | default .Values.global.serviceAccount.name | default "default" -}}
{{- end -}}
{{- end }}


{{/*
Compute environment variables from global and local values.
- .Values.env overrides .Values.global.env (use one or the other)
- .Values.extraEnv is always appended to the base env (global or local)
*/}}
{{- define "epoch8-common.env" -}}
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
{{- define "epoch8-common.hostAliases" -}}
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
{{- define "epoch8-common.configChecksumAnnotations" -}}
{{- if .Values.configs }}
{{- if not (hasKey .Values "autoRestartOnConfigChange") | or .Values.autoRestartOnConfigChange }}
checksum/configs: {{ toYaml .Values.configs | sha256sum }}
{{- end }}
{{- end }}
{{- end }}


{{/*
Generate all pod annotations including checksums and user-provided annotations.
Outputs the complete annotations block only if there are annotations to add.
Usage: {{- include "epoch8-common.podAnnotations" . | nindent <spaces> }}
*/}}
{{- define "epoch8-common.podAnnotations" -}}
{{- $checksumAnnotations := include "epoch8-common.configChecksumAnnotations" . -}}
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
