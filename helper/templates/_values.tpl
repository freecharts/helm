{{/*
# Copyright FreeCharts.
# SPDX-License-Identifier: MIT License
*/}}

{{/*
Renders a value that contains template perhaps with scope if the scope is present. based on bitnami
Usage:
{{ include "helper.values.render" ( dict "value" .Values.path.to.the.Value "context" $ ) }}
{{ include "helper.values.render" ( dict "value" .Values.path.to.the.Value "context" $ "scope" $app ) }}
*/}}
{{- define "helper.values.render" -}}
{{- $value := typeIs "string" .value | ternary .value (.value | toYaml) }}
{{- if contains "{{" (toJson .value) }}
  {{- if .scope }}
      {{- tpl (cat "{{- with $.RelativeScope -}}" $value "{{- end }}") (merge (dict "RelativeScope" .scope) .context) }}
  {{- else }}
    {{- tpl $value .context }}
  {{- end }}
{{- else }}
    {{- $value }}
{{- end }}
{{- end -}}

{{/*
Returns a Base64-encoded value for a Secret.

Parameters:
  secretName : Secret name
  namespace  : Secret namespace
  key        : Key to retrieve from the Secret
  value      : Value provided from values.yaml (plain text)
  length     : Generated password length (optional, default: 32)

Priority order:
1. Existing value from the Secret.
2. Value provided in values.yaml.
3. Newly generated random password.
*/}}
{{- define "helper.secret.value" -}}
{{- $secret := lookup "v1" "Secret" .namespace .secretName -}}
{{- $pwd := "" -}}

{{- if $secret }}
  {{- $pwd = get $secret.data .key }}
{{- end }}

{{- if empty $pwd }}
  {{- if not (empty .value) }}
    {{- $pwd = .value | b64enc }}
  {{- else }}
    {{- $pwd = randAlphaNum (default 32 .length) | b64enc }}
  {{- end }}
{{- end }}

{{- $pwd -}}

{{- end }}

