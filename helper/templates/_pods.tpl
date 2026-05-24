{{/*
# Copyright FreeCharts.
# SPDX-License-Identifier: MIT License
*/}}

{{/*
Renders security context for pods and containers.
Usage:
{{ include "helper.pods.renderSecurityContext" ( dict "securityContext" .Values.path.to.the.Value) }}
*/}}
{{- define "helper.pods.renderSecurityContext" -}}
{{- $securityContext := .securityContext | default dict -}}

{{- if $securityContext }}
  {{- with $securityContext }}
    {{- printf "securityContext:" -}}
    {{- toYaml . | nindent 2 }}
  {{- end }}
{{- end }}

{{- end -}}