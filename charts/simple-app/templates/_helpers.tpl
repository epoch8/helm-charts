{{/*
All common helpers are provided by the simple-charts-common library chart.
See: charts/simple-charts-common/templates/_helpers.tpl
*/}}


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
