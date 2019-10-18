---
layout: post
title: "Get port mapping in kubernetes cluster"
description: There are several steps to connect to a kubernetes cluster and see port mapping.
summary: There are several services hosted by kubernetes cluster. How to obtain the ports they are available for client application?
---

A few days ago I was asked for a way to get external port of the service hosted under kubernetes.
Internal listening port inside the container is mapped to outside world.

### How to get kubernetes ports mappings.

1) install `kubectl` tool

2) get `kubeconfig` file for specific kubernetes cluster

3) use specific config as default one
```
cp kubeconfig ~/.kube/config
```
As alternative, we can specify the config via arg. `--kubeconfig`

4) be sure it's used now
```
kubectl config view
```

5) list namespaces
```
kubectl get namespace
```

6) list services with port mappings in the namespace
```
kubectl get services -n some-namespace
```
