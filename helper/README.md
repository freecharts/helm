# FreeCharts helm utilities

## Description

This helper library offers several utilities to simplify creating Helm templates.

## Components

| Name | Description | Root path |
| ---- | ----------- | --------- |
| _images | Helpers to build container image names, tags and pull policies. | helper.images |
| _labels | Common label generators for charts and Kubernetes resources. | helper.labels |
| _names | Templates related to names, e.g., chart name, fully qualified name, storage name. | helper.names |
| _pods | Pod-related helpers (annotations, security context, sidecars, common pod fragments). | helper.pods |
| _resources | Helpers for resource requests/limits and default resource configuration. | helper.resources |
| _values | Utilities for value lookups, defaulting and merging chart values. | helper.values |

## Usage examples

Below are short snippets showing common usages for each helper. Use these inside your chart templates.

### Names

```yaml
{{"{{ include \"helper.names.name\" . }}"}}
{{"{{ include \"helper.names.fullname\" . }}"}}
{{"{{ include \"helper.names.namespace\" . }}"}}
{{"{{ include \"helper.names.storageClass\" (dict \"persistence\" .Values.persistence \"global\" .Values.global) }}"}}
```

### Images

```yaml
{{"{{ include \"helper.images.image\" (dict \"imageRoot\" .Values.image \"global\" .Values.global \"chart\" .Chart) }}"}}
{{"{{ include \"helper.images.pullPolicy\" (dict \"imageRoot\" .Values.image \"global\" .Values.global \"chart\" .Chart) }}"}}
{{"{{ include \"helper.images.imagePullSecrets\" (dict \"imageRoot\" .Values.image \"global\" .Values.global) }}"}}
```

### Labels

```yaml
labels:
  {{"{{ include \"helper.labels.labels\" . | indent 2 }}"}}
```

### Pods

```yaml
{{"{{ include \"helper.pods.renderSecurityContext\" (dict \"securityContext\" .Values.securityContext) | indent 0 }}"}}
```

### Resources

```yaml
{{"{{ include \"helper.resources.preset\" (dict \"type\" \"small\") }}"}}
```

### Values renderer

```yaml
{{"{{ include \"helper.values.render\" (dict \"value\" .Values.someTemplateValue \"context\" $) }}"}}
```

## Expanded examples

The following are fuller examples showing how you might use each helper inside a template and an approximate rendered output.

### Names (deployment metadata)

```yaml
metadata:
  name: {{"{{ include \"helper.names.fullname\" . }}"}}
  namespace: {{"{{ include \"helper.names.namespace\" . }}"}}
  labels:
    {{"{{ include \"helper.labels.selectorLabels\" . | indent 4 }}"}}
# Rendered (example):
# name: myrelease-mychart
# namespace: default
# app.kubernetes.io/name: mychart
# app.kubernetes.io/instance: myrelease
```

### Images (container spec)

```yaml
containers:
- name: main
  image: {{"{{ include \"helper.images.image\" (dict \"imageRoot\" .Values.image \"global\" .Values.global \"chart\" .Chart) }}"}}
  imagePullPolicy: {{"{{ include \"helper.images.pullPolicy\" (dict \"imageRoot\" .Values.image \"global\" .Values.global \"chart\" .Chart) }}"}}
# Rendered (example):
# image: myregistry/myrepo:1.2.3
# imagePullPolicy: IfNotPresent
```

### Pods (security context)

```yaml
spec:
  {{"{{ include \"helper.pods.renderSecurityContext\" (dict \"securityContext\" .Values.securityContext) | indent 2 }}"}}
# Rendered (example):
# securityContext:
#   runAsUser: 1000
#   fsGroup: 2000
```

### Resources (preset)

```yaml
resources:
  {{"{{ include \"helper.resources.preset\" (dict \"type\" \"small\") | indent 2 }}"}}
# Rendered (example):
# limits:
#   cpu: 500m
#   memory: 512Mi
# requests:
#   cpu: 250m
#   memory: 256Mi
```

### Values renderer (templated values)

```yaml
command: ["/bin/sh", "-c", {{"{{ include \"helper.values.render\" (dict \"value\" .Values.startupCommand \"context\" $) }}"}}]
# If .Values.startupCommand contains a tpl template this will render it with the current scope.
```
