# 🏗️ High-Level Design (HLD)

## Overview

This system provisions a single-node k3s cluster on AWS EC2 using Terraform. It deploys a demo application (NGINX), configures autoscaling via HPA, and integrates observability tools.

## Components

- **AWS EC2**: Ubuntu 24.04 instance
- **Terraform**: Infrastructure provisioning
- **k3s**: Lightweight Kubernetes control plane
- **NGINX**: Demo application
- **metrics-server**: Resource metrics for autoscaling
- **HPA**: Scales pods based on CPU usage
- **Grafana**: Visualizes metrics
- **Kyverno**: Applies hibernation policies

## Architecture Diagram

```
Developer 
│ 
▼ Terraform 
│ 
▼ AWS EC2 (Ubuntu 24.04) 
└── k3s 
├── NGINX Pod 
├── metrics-server 
├── HPA 
├── Grafana 
└── Kyverno
```


## Interfaces

- SSH access to EC2  
- NodePort access to NGINX  
- Grafana dashboard via NodePort  
- Kyverno policies applied via Kubernetes manifests
