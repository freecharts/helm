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

{{/*
Renders soft affinity for pods.
Usage:
{{ include "helper.pods.renderSoftAffinity" ( dict "component" .Values.path.to.the.Value, "role" .Values.path.to.the.Role, "context" $) }}
*/}}

{{- define "helper.pods.renderSoftAffinity" -}}

{{- $component := default "" .component -}}
{{- $role := default "" .role -}}
preferredDuringSchedulingIgnoredDuringExecution:
  - podAffinityTerm:
      topologyKey: "kubernetes.io/hostname"
      labelSelector:
        matchLabels: {{- include "helper.labels.selectorLabels" .context | nindent 10 }}
          {{- if not (empty $component) }}
          app.kubernetes.io/component: {{ $component }}
          {{- end }}
          {{- if not (empty $role) }}
          role: {{ $role }}
          {{- end }}
    weight: 100

{{- end -}}
