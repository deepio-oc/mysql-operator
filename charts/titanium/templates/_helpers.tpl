{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "serviceName" -}}
{{ .Release.Name }}-mysql
{{- end -}}

{{- define "readServiceName" -}}
{{- include "serviceName" . -}}-read
{{- end -}}

{{- define "master-node-name" -}}
{{ .Release.Name }}-titanium-0
{{- end -}}

{{- define "dbUser" -}}
{{ required "Missing .db.user" .Values.db.user }}
{{- end -}}

{{- define "dbPassword" -}}
{{ required "Missing .db.password" .Values.db.password }}
{{- end -}}

{{- define "dbName" -}}
{{ required "Missing .db.name" .Values.db.name }}
{{- end -}}

{{- define "dbHost" -}}
{{- template "master-node-name" . }}.{{ template "serviceName" . }}
{{- end -}}

{{- define "dbPort" -}}
3306
{{- end -}}

{{- define "db-connect-url" -}}
mysql://{{ template "dbUser" . }}:{{ template "dbPassword" . }}@
{{- template "dbHost" . }}:{{ template "dbPort" }}/
{{- template "dbName" . -}}?charset=utf8mb4&conn_max_age=300
{{- end -}}