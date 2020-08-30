# Helm Chart for HAProxy Prometheus Exporter

[HAProxy Exporter](https://github.com/prometheus/haproxy_exporter) is a
Prometheus Exporter for HAProxy.

## TL;DR;

```bash
helm install .
```

## Introduction

This chart bootstraps a HAProxy Prometheus Exporter on a
[Kubernetes](http://kubernetes.io) cluster using the
[Helm](https://helm.sh) package manager.


## Prerequirements
In order for HAProxy Exporter to be able to grab the stats of your HAProxy
instance, add the following to your
HAProxy configuration under `/etc/haproxy/haproxy.cfg`:

```console
listen stats # Define a listen section called "stats"
  bind :9000 # Listen on localhost:9000
  mode http
  stats enable  # Enable stats page
  stats hide-version  # Hide HAProxy version
  stats realm Haproxy\ Statistics  # Title text for popup window
  stats uri /haproxy_stats  # Stats URI
```

## Installing the chart
To install the chart with the release name `my-release`:

```bash
helm install . --name my-release
```

The command deploys HAProxy Exporter on the Kubernetes cluster in the
default configuration. The [configuration](#configuration) section lists
the parameters that can be configured during installation.

You can specify each parameter using the `--set key=value[,key=value]`
argument to `helm install`. This is not recommended - settings should be
set inside a `values.yaml` file that can be placed into an scm like git.

Recommended installation:

```bash
kubectl config set-context $(kubectl config current-context) --namespace=default

helm upgrade haproxy-exporter-proxy1 \
    . \
    --install \
    --version 1.0.0 \
    --namespace default \
    --recreate-pods \
    -f values.yaml \
    --dry-run

helm upgrade haproxy-exporter-proxy1 \
    . \
    --install \
    --version 1.0.0 \
    --namespace default \
    -f values.yaml

kubectl get pods
```

> **Note**: I advise to install one release of this helm chart for each HAProxy you
want to monitor.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
helm del --purge my-release
```

The command removes all the Kubernetes components associated with the chart
and deletes the release.

## Configuration

The following table lists the configurable parameters of the chart and their default
values.

| Parameter                                     | Description                                | Default                                                                                      |
|-----------------------------------------------|--------------------------------------------|----------------------------------------------------------------------------------------------|
| `image.repository`                            | Image repository                           | `prom/haproxy-exporter`                                                                      |
| `image.tag`                                   | Image tag                                  | `v0.10.0`                                                                                    |
| `image.pullPolicy`                            | Image pull policy                          | `IfNotPresent`                                                                               |
| `image.pullSecrets`                           | Specify image pull secrets                 | `nil`                                                                                        |
| `pod.args`                                    | Specify the args of the pod - mandatory!   | `"--haproxy.scrape-uri=http://192.168.0.1:9000/haproxy_stats?stats;csv"`                     |
| `pod.annotations`                             | Specify annotations for the pod            | `nil`                                                                                        |
| `service.type`                                | Specify the service type                   | `ClusterIP`                                                                                  |
| `service.port`                                | Specify the service port                   | `ClusterIP`                                                                                  |
| `service.annotations`                         | Specify annotations for the service        | `prometheus.io/path: "/metrics"` `prometheus.io/port: "9101"` `prometheus.io/scrape: "true"` |   
| `resources`                                   | Kubernetes resources                       | `nil`                                                                                        |
| `ingress`                                     | Kubernetes ingress configuration           | `nil`                                                                                        |
                                                                      