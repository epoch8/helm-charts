{{/*
All common helpers are provided by the epoch8-common library chart.
See: charts/epoch8-common/templates/_helpers.tpl
*/}}

{{/*
Compute image based on global values and image specific values
*/}}
{{- define "simple-app.initJobImage" -}}
{{- $initJobImage := .Values.initJob -}}
{{- $image := .Values.image -}}
{{- $global := .Values.global.image -}}
{{- $imageName := $initJobImage.repository | default $image.repository | default $global.repository -}}
{{- $imageTag := $initJobImage.tag | default $image.tag | default $global.tag -}}
{{- printf "%s:%s" $imageName $imageTag | trimSuffix ":" }}
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
