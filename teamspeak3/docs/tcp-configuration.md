# TCP Configuration
This chart currently has limited support for TCP ports. See [Known Limitations](../README.md#known-limitations)  
[Check](https://github.com/janosi/enhancements/blob/mixedprotocollb/keps/sig-network/20200103-mixed-protocol-lb.md#implementation-detailsnotesconstraints) if your enviorment supports `mixed protocols`.

## How to Enable TCP
 * Set `service.tcp.enabled` to `true` in the configuration option; and
 * folow any additional specific instructions below

The Following are known supported `LoadBalancers`:

### MetalLB
MetalLB supports `mixed protocols` by allowing multiple services to share the same IP address. See [IP Address Sharing](https://metallb.universe.tf/usage/#ip-address-sharing)  
This is done by combining two services on a specfic annotation.


Settings required:

| Settings               | Value                                           | Comment                                                        |
| -----------------------|-------------------------------------------------|----------------------------------------------------------------|
| `services.tcp.type`    | `seperate`                                      | (default)                                                      |
| `services.annotations` | `metallb.universe.tf/allow-shared-ip`: [string] | Where [string] is a string that uniquely identifies `shared-ip` services.|

### Azure CPI LB (Untested)
Azure supports `mixed protocols` by declaring that the ports specfied in the service are both TCP and UDP.
This is done by specifying an annotation on a single service.

Settings required:

| Settings               | Value                                                                  | Comment 
| -----------------------|------------------------------------------------------------------------|-----------------------------------------|
| `services.tcp.type`    | `combined`                                                             |                                         |
| `services.annotations` | `service.beta.kubernetes.io/azure-load-balancer-mixed-protocols`: true |                                         |
