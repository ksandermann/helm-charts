# Helm Chart for Teamspeak 3 Server

[Teamspeak](https://www.teamspeak.com) is a voice and chat tool for teams providing voice channel features.

## TL;DR;

```bash
helm repo add ksandermann http://charts.sandermann.cloud
helm repo update
helm upgrade teamspeak \
    teamspeak \
    --install \
    --namespace default
```
NB: Limited support for TCP ports. See [Known Limitations](#known-limitations)

## Installing the chart
The [configuration](#configuration) section lists
the parameters that can be configured during installation.

You can specify each parameter using the `--set key=value[,key=value]`
argument to `helm install`. This is not recommended - settings should be
set inside a `values.yaml` file that can be placed into an scm like git.

Recommended installation:

```bash
kubectl config set-context $(kubectl config current-context) --namespace=default

helm repo add ksandermann http://charts.sandermann.cloud
helm repo update

helm upgrade ts3 \
    teamspeak \
    --install \
    --namespace default \
    -f values.yaml \
    --dry-run

helm upgrade ts3 \
    teamspeak \
    --install \
    --namespace default \
    -f values.yaml

kubectl get pods
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
helm del ts3
```

The command removes all the Kubernetes components associated with the chart
and deletes the release.

## Configuration

The following table lists the configurable parameters of the chart and their default
values.

| Parameter                   | Description                                                                                 | Default         |
|-----------------------------|---------------------------------------------------------------------------------------------|-----------------|
| `image.repository`          | Image repository                                                                            | `teamspeak`     |
| `image.tag`                 | Image tag                                                                                   | `3.12.1`        |
| `image.pullPolicy`          | Image pull policy                                                                           | `Always`        |
| `image.pullSecret`          | Specify image pull secrets                                                                  | `nil`           |
| `pod.annotations`           | Specify annotations for the pod                                                             | `nil`           |
| `service.type`              | Specify the service type - only LB and NodePort supported                                   | `LoadBalancer`  |
| `service.ip`                | Specify the requested IP Address - only LB supported                                        | `nil`           |
| `service.nodePort`          | Specify the service nodePort                                                                | `30987`         |
| `service.tcp.enabled`       | Enable/Disable TCP ports - limited support - See [TCP configuration](#tcp-configuration)    | `disabled`      |
| `service.tcp.type`          | Specify the tcp implementation type - See [TCP configuration](#tcp-configuration)           | `seperate`      |
| `service.annotations`       | Annotations for the service                                                                 | `nil`           | 
| `resources`                 | Kubernetes resources                                                                        | `nil`           |
| `nodeSelector`              | Kubernetes nodeSelectors for the deployment                                                 | `nil`           |
| `tolerations`               | Kubernetes tolerations for the deployment                                                   | `nil`           |
| `affinity`                  | Kubernetes affinities for the deployment                                                    | `nil`           |
| `persistence.enabled`       | Enable/Disable persistence                                                                  | `disabled`      |
| `persistence.accessMode`    | Accessmode for the PVC                                                                      | `nil`           |
| `persistence.existingClaim` | Name of an existing PVC to use                                                              | `nil`           |
| `persistence.annotations`   | Annotations for the PVC                                                                     | `nil`           |
| `persistence.storageClass`  | StorageClass for the PVC                                                                    | `nil`           |
| `persistence.storageSize`   | Size of the PVC                                                                             | `nil`           |

## TCP Configuration
This chart currently has limited support for TCP ports. See [Known Limitations](#known-limitations)  
[Check]((https://github.com/janosi/enhancements/blob/mixedprotocollb/keps/sig-network/20200103-mixed-protocol-lb.md#implementation-detailsnotesconstraints)) if your enviorment supports `mixed protocols`.

### How to Enable TCP
See [TCP configuration](./docs/tcp-configuration.md)

## Accessing the server
After deploying the helm chart, you will see instructions to access your server in the commandline's stdout.

## Known Limitations
1. This chart currently only supports the TCP ports if:
    * the `service.type` is of type `LoadBalancer`; and
    * the ``LoadBalancer`` supports mixing both `UDP` and `TCP` ports. 
    (See [official support request](https://github.com/kubernetes/kubernetes/issues/23880))

To configure TCP in supported environments see [TCP configuration](./docs/tcp-configuration.md)

This means you can access and manage only the single
default virtual server inside the Teamspeak server. If you want to manage multiple server, you can simply deploy this
chart multiple times.
