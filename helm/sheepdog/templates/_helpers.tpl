{{/*
Expand the name of the chart.
*/}}
{{- define "sheepdog.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "sheepdog.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "sheepdog.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "sheepdog.labels" -}}
helm.sh/chart: {{ include "sheepdog.chart" . }}
{{ include "sheepdog.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sheepdog.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sheepdog.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: {{ include "sheepdog.name" . }}
release: {{ .Values.releaseLabel }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "sheepdog.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "sheepdog.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
 Postgres Password lookup Sheepdog
*/}}
{{- define "sheepdog.postgres.password" -}}
{{- $localpass := (lookup "v1" "Secret" "postgres" "postgres-postgresql" ) -}}
{{- if $localpass }}
{{- default (index $localpass.data "postgres-password" | b64dec) }}
{{- else }}
{{- default .Values.secrets.sheepdog.password }}
{{- end }}
{{- end }}

{{/*
 Postgres Password lookup Fence
*/}}
{{- define "fence.postgres.password" -}}
{{- $localpass := (lookup "v1" "Secret" "postgres" "postgres-postgresql" ) -}}
{{- if $localpass }}
{{- default (index $localpass.data "postgres-password" | b64dec) }}
{{- else }}
{{- default .Values.secrets.fence.password }}
{{- end }}
{{- end }}

{{/*
Define ddEnabled
*/}}
{{- define "sheepdog.ddEnabled" -}}
{{- if .Values.global }}
{{- .Values.global.ddEnabled }}
{{- else}}
{{- .Values.dataDog.enabled }}
{{- end }}
{{- end }}

{{/*
Define dictionaryUrl
*/}}
{{- define "sheepdog.dictionaryUrl" -}}
{{- if .Values.global }}
{{- .Values.global.dictionaryUrl }}
{{- else}}
{{- .Values.dictionaryUrl }}
{{- end }}
{{- end }}