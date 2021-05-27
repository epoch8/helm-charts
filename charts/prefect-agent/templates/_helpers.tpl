{{/*
Expand the name of the chart.
*/}}
{{- define "prefect-agent.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "prefect-agent.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "prefect-agent.labels" -}}
helm.sh/chart: {{ include "prefect-agent.chart" . }}
{{ include "prefect-agent.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "prefect-agent.selectorLabels" -}}
app.kubernetes.io/name: {{ include "prefect-agent.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
