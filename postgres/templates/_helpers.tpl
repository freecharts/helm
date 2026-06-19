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
Create the name of the pgpool
*/}}
{{- define "postgres.pgpoolName" -}}
{{- printf "%s-%s" .Release.Name "pgpool" | trunc 63 | trimSuffix "-" -}}
{{- end }}