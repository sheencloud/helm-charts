{{/*
Expand the name of the chart.
*/}}
{{- define "hyperkuber.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hyperkuber.fullname" -}}
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

{{- define "hyperkuber.web" -}}
  {{- printf "%s-web" (include "hyperkuber.fullname" .) -}}
{{- end -}}


{{- define "hyperkuber.server" -}}
  {{- printf "%s-server" (include "hyperkuber.fullname" .) -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "hyperkuber.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "hyperkuber.web.labels" -}}
helm.sh/chart: {{ include "hyperkuber.chart" . }}
{{ include "hyperkuber.web.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "hyperkuber.server.labels" -}}
helm.sh/chart: {{ include "hyperkuber.chart" . }}
{{ include "hyperkuber.server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/*
Selector labels
*/}}
{{- define "hyperkuber.web.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hyperkuber.web" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "hyperkuber.server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hyperkuber.server" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "hyperkuber.web.serviceAccountName" -}}
{{- if .Values.web.serviceAccount.create }}
{{- default (include "hyperkuber.web" .) .Values.web.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.web.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "hyperkuber.server.serviceAccountName" -}}
{{- if .Values.server.serviceAccount.create }}
{{- default (include "hyperkuber.server" .) .Values.server.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.server.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "mysql.fullname" -}}
{{- printf "%s-%s" .Release.Name "mysql" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "redis.fullname" -}}
{{- printf "%s-%s" .Release.Name "redis" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "hyperkuber.ingress.apiVersion" -}}
{{- if semverCompare "<1.14-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "extensions/v1beta1" -}}
{{- else -}}
{{- print "networking.k8s.io/v1" -}}
{{- end -}}
{{- end -}}