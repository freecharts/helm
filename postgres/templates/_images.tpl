{{/*
# Copyright FreeCharts.
# SPDX-License-Identifier: MIT License
*/}}

{{/*
Return the proper image name from values.
{{ include "helper.images.image" ( dict "imageRoot" .Values.path.to.the.image "global" .Values.global "chart" .Chart ) }}
*/}}
{{- define "helper.images.image" -}}
{{- $registryName := default .imageRoot.registry ((.global).imageRegistry) -}}
{{- $repositoryName := .imageRoot.repository -}}
{{- $separator := ":" -}}
{{- $termination := default "latest" .imageRoot.tag | toString -}}

{{- if not .imageRoot.tag }}
  {{- if .chart }}
    {{- $termination = .chart.AppVersion | toString -}}
  {{- end }}
{{- end }}
{{- if .imageRoot.digest }}
    {{- $separator = "@" -}}
    {{- $termination = .imageRoot.digest | toString -}}
{{- end }}
{{- if $registryName }}
    {{- printf "%s/%s%s%s" $registryName $repositoryName $separator $termination -}}
{{- else }}
    {{- printf "%s%s%s"  $repositoryName $separator $termination -}}
{{- end }}

{{- end -}}

{{/*
Return the proper image pull secret names from values.
{{- include "helper.images.imagePullSecrets" ( dict "imageRoot" .Values.path.to.the.image "global" .Values.global ) -}}
*/}}
{{- define "helper.images.imagePullSecrets" -}}
{{- $imagePullSecrets := default .imageRoot.imagePullSecrets ((.global).imagePullSecrets) -}}
{{- if not .imageRoot.tag }}
  {{- if .chart }}
    {{- $termination = .chart.AppVersion | toString -}}
  {{- end }}
{{- end }}

{{- if $imagePullSecrets }}
  {{- with $imagePullSecrets }}
    {{- printf "imagePullSecrets:" -}}
    {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- println "" -}}
{{- end }}

{{- end -}}

{{/*
Return the proper image pullPolicy from values.
{{ include "helper.images.pullPolicy" ( dict "imageRoot" .Values.path.to.the.image "global" .Values.global "chart" .Chart ) }}
*/}}
{{- define "helper.images.pullPolicy" -}}
{{- $pullPolicy := default .imageRoot.pullPolicy ((.global).pullPolicy) -}}

{{- if not $pullPolicy }}
  {{- if and (not .imageRoot.tag) (not .chart) -}}
    {{- $pullPolicy = "Always" -}}
  {{- else }}
    {{- $pullPolicy = "IfNotPresent" -}}
  {{- end }}
{{- end }}
{{- printf "%s" $pullPolicy -}}

{{- end -}}