{{/*
# Copyright FreeCharts.
# SPDX-License-Identifier: MIT License
*/}}

{{/*
Return a resource request/limit object based on a given preset.
{{ include "helper.resources.preset" (dict "type" "nano") -}}
*/}}
{{- define "helper.resources.preset" -}}

{{- $type := .type | default "nano" -}}
{{- $presets := dict 
    "nano" (dict 
        "limits" (dict "cpu" "100m" "memory" "128Mi") 
        "requests" (dict "cpu" "50m" "memory" "64Mi")) 
    "small" (dict 
        "limits" (dict "cpu" "500m" "memory" "512Mi") 
        "requests" (dict "cpu" "250m" "memory" "256Mi")) 
    "medium" (dict 
        "limits" (dict "cpu" "1" "memory" "1Gi") 
        "requests" (dict "cpu" "500m" "memory" "512Mi")) 
    "large" (dict 
        "limits" (dict "cpu" "2" "memory" "2Gi") 
        "requests" (dict "cpu" "1" "memory" "1Gi"))
    "huge" (dict 
        "limits" (dict "cpu" "3" "memory" "4Gi") 
        "requests" (dict "cpu" "1.5" "memory" "2Gi"))
-}}
{{- if hasKey $presets $type -}}
{{- index $presets $type | toYaml -}}
{{- else -}}
{{- printf "Error: Unknown resources preset '%s'. Available presets are: %s" .type (join "," (keys $presets)) | fail -}}
{{- end -}}

{{- end -}}
