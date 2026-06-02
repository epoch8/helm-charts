{{/*
All common helpers are provided by the simple-charts-common library chart.
See: charts/simple-charts-common/templates/_helpers.tpl
*/}}


{{/*
Compute the effective container port.
Priority: .Values.port > .Values.global.port > 8000
*/}}
{{- define "simple-app.port" -}}
{{- .Values.port | default .Values.global.port | default 8000 -}}
{{- end }}


{{/*
Compute the effective probe path.
Priority: .Values.probe.path > .Values.global.probe.path > "/"
*/}}
{{- define "simple-app.probePath" -}}
{{- $probe := .Values.probe | default .Values.global.probe | default dict -}}
{{- $probe.path | default "/" -}}
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
