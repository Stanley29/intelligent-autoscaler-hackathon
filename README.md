# 🚀 Intelligent Autoscaler Hackathon

A minimal, reproducible infrastructure-as-code project that deploys a k3s Kubernetes cluster on AWS using Terraform, integrates metrics-server, and demonstrates dynamic autoscaling with Horizontal Pod Autoscaler (HPA). Designed for solo execution within hours, this project balances clarity, cost-efficiency, and real-world DevOps workflows.

---

## 🎯 Project Purpose

This project showcases:
- How to provision cloud infrastructure using Terraform
- How to bootstrap a lightweight Kubernetes cluster (k3s) on EC2
- How to deploy and expose containerized applications
- How to integrate metrics-server for resource monitoring
- How to configure and trigger autoscaling based on CPU usage
- How to simulate load and validate scaling behavior

It’s ideal for:
- Hackathons
- Onboarding exercises
- DevOps training
- Infrastructure reproducibility demos

---

```markdown
## 📁 Project Structure

```plaintext

intelligent-autoscaler-hackathon/ 
├── main.tf # Terraform config for VPC, EC2, SG, and k3s bootstrap 
├── variables.tf # Optional: input variables for customization 
├── outputs.tf # Optional: public IP and other outputs 
├── README.md # Project overview and execution guide

```

---

## 🛠️ Step-by-Step Execution

### ✅ Step 1: Infrastructure Deployment

**What was done:**
- Terraform created:
  - Custom VPC, subnet, internet gateway, route table
  - Security group allowing SSH, HTTP, HTTPS, NodePort
  - EC2 instance (Ubuntu 24.04) with k3s installed via `user_data`

**Outcome:**
- EC2 instance live at `13.62.47.75`
- k3s control plane verified via:

  ```
  
  sudo kubectl get nodes
  
 ```
 
### ✅ Step 2: Application Deployment
What was done:

Deployed NGINX pod:

```
sudo kubectl create deployment hello-k3s --image=nginx
```

Outcome:

Pod is running and healthy

### ✅ Step 3: Service Exposure
What was done:

Exposed pod via NodePort:

```
sudo kubectl expose deployment hello-k3s --port=80 --type=NodePort
```
Added SG rule for ports 30000–32767

Accessed NGINX at:

```
http://13.62.47.75:30533
```

### ✅ Step 4: Metrics Server Installed
What was done:

Applied official metrics-server manifest:

```
sudo kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

Next:

Verify metrics-server health

Confirm metrics availability

### ✅ Step 5: Metrics Server Verified
What was done:

Restarted k3s to recover from API timeout

Verified metrics-server pod is running

Next:

Confirm metrics flow:

```
sudo kubectl top nodes
sudo kubectl top pods
```

### ✅ Step 6: Metrics Verified
What was done:

Verified live metrics via:

```
kubectl top nodes
kubectl top pods
```

Outcome:

CPU and memory usage visible

Cluster ready for autoscaling

### ✅ Step 7: HPA Configured
What was done:

Created autoscaler:

```
sudo kubectl autoscale deployment hello-k3s --cpu-percent=50 --min=1 --max=5
```

Outcome:

HPA active, watching CPU usage

### ✅ Step 8: Autoscaler Activated
What was done:

Patched deployment with CPU request:

```
sudo kubectl patch deployment hello-k3s \
  --patch '{"spec":{"template":{"spec":{"containers":[{"name":"nginx","resources":{"requests":{"cpu":"100m"}}}]}}}}'
  ```
  
Outcome:

HPA sees metrics and is ready to scale

### ✅ Step 9: Simulated CPU Load
What was done:

Entered pod shell:

```
sudo kubectl exec -it deploy/hello-k3s -- /bin/bash
```

Ran CPU-intensive loop:

```
yes > /dev/null
```

Next:

Exit shell and check:

```
sudo kubectl get hpa
```

### ✅ Step 10: Autoscaler Verified
What was done:

HPA tracked CPU usage

Replicas scaled from 1 → 4

```markdown
## 📊 Final Recap: What You’ve Built

| Component            | Status       | Notes                          |
|----------------------|--------------|--------------------------------|
| EC2 + VPC + SG       | ✅ Deployed   | Terraform-managed              |
| k3s cluster          | ✅ Installed  | Verified with kubectl          |
| NGINX pod            | ✅ Running    | Via hello-k3s deployment       |
| NodePort service     | ✅ Exposed    | Accessible at http://13.62.47.75:30533 |
| Metrics server       | ✅ Installed  | Live metrics via kubectl top   |
| HPA autoscaler       | ✅ Working    | Scaled from 1 → 4 pods         |
| Stress pod           | ✅ Simulated  | Triggered CPU load             |
```

## 🧹 Teardown and Cost-Saving
To clean up all AWS resources:

```
terraform destroy

```
Resources destroyed:

EC2 instance

VPC, subnet, route table, internet gateway

Security group

Public IP

Result:

No lingering costs

Clean state

Fully reproducible infrastructure

## 🧠 Notes
Metrics-server must be installed manually

CPU requests are required for HPA to function

Stress pods or shell loops can simulate load

Restarting k3s may be needed if API stalls
 