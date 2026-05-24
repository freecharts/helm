{{/*
# Copyright FreeCharts.
# SPDX-License-Identifier: MIT License
*/}}

{{/*
Common labels
*/}}
{{- define "helper.labels.labels" -}}
helm.sh/chart: {{ include "helper.names.chart" . }}
{{ include "helper.labels.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "helper.labels.selectorLabels" -}}
app.kubernetes.io/name: {{ include "helper.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}