# 🧠 Architectural Decision Record (ADR)

## Context

We need a reproducible, cost-efficient autoscaling platform for preview environments in AWS. The system must support dynamic scaling, observability, and resource optimization.

## Decision

- **Terraform** is chosen for infrastructure provisioning due to its declarative syntax, reproducibility, and AWS support.
- **k3s** is selected as a lightweight Kubernetes distribution suitable for single-node EC2 deployment.
- **Horizontal Pod Autoscaler (HPA)** is used for dynamic scaling based on CPU metrics.
- **metrics-server** is integrated to provide live resource metrics for HPA.
- **NGINX** is used as a demo workload to validate autoscaling behavior.
- **Grafana** will be added for observability dashboards.
- **Kyverno** will be used to implement hibernation policies for unused workloads.

## Status

Accepted — implemented in Terraform and Kubernetes manifests.
