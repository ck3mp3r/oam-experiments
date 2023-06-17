{{/* Create a metadata name based on the release name */}}
{{- define "product.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
