{{/*
Override the release name
*/}}
{{- define "haproxy-exporter.release_name" -}}
{{- $release_name := default .Release.Name .Values.release_name }}
{{- if .Values.release_suffix }}
{{-   printf "%s%s" $release_name .Values.release_suffix }}
{{- else }}
{{-   $release_name }}
{{- end }}
{{- end }}
