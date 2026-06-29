{{/*
# Copyright FreeCharts.
# SPDX-License-Identifier: MIT License
*/}}

{{/*
Create the name of the service account to use
*/}}
{{- define "postgres.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "helper.names.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the primary service
*/}}
{{- define "postgres.primaryName" -}}
{{- printf "%s-primary" (include "helper.names.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create the name of the headless service
*/}}
{{- define "postgres.headlessName" -}}
{{- printf "%s-hl" (include "helper.names.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create the name of the pgpool
*/}}
{{- define "postgres.pgpoolName" -}}
{{- printf "%s-pgpool" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}