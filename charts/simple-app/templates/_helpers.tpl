{{/*
Expand the name of the chart.
*/}}
{{- define "simple-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "simple-app.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- if .Values.nameOverride -}}
{{- $name := include "simple-app.name" . }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- else -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end -}}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "simple-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Compute image based on global values and image specific values
*/}}
{{- define "simple-app.image" -}}
{{- $image := .Values.image -}}
{{- $global := .Values.global.image -}}
{{- $imageName := default $global.repository $image.repository -}}
{{- $imageTag := default $global.tag $image.tag -}}
{{- printf "%s:%s" $imageName $imageTag | trimSuffix ":" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "simple-app.labels" -}}
helm.sh/chart: {{ include "simple-app.chart" . }}
{{ include "simple-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "simple-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "simple-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Should the service account be created

If global SA is defined and serviceAccount.create is not set explicitly, then global SA will be used
else local serviceAccount.create will be used
*/}}
{{- define "simple-app.serviceAccount.create" -}}
{{- if .Values.global.serviceAccount.name -}}
{{- default false .Values.serviceAccount.create -}}
{{- else -}}
{{- default true .Values.serviceAccount.create -}}
{{- end -}}
{{- end -}}

{{/*
{{- end }}

{{/*
Name of the service account to use
*/}}
{{- define "simple-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "simple-app.fullname" .) (default .Values.global.serviceAccount.name .Values.serviceAccount.name) }}
{{- else }}
{{- default "default" (default .Values.global.serviceAccount.name .Values.serviceAccount.name) }}
{{- end }}
{{- end }}


{{/*
Does deployment needs recreate
*/}}
{{- define "simple-app.needs-recreate" -}}
{{- $needsRecreate := "" -}}
{{- range $key, $value := .Values.volumes -}}
    {{- if and (not $value.emptyDir) (not $value.secret) (not $value.configMap) -}}
        {{- $needsRecreate = "true" -}}
        {{- break -}}
    {{- end -}}
{{- end -}}
{{- $needsRecreate -}}
{{- end -}}
