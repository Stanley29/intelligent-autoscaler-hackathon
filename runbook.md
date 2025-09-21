# 🧠 Intelligent Autoscaler — Runbook

Цей документ описує покроковий запуск проєкту через Terraform на AWS.

---

## 🔧 Передумови

- AWS акаунт з доступом до EC2, VPC, IAM
- AWS credentials налаштовані локально (`~/.aws/credentials` або через env vars)
- Terraform встановлений (`terraform -v`)
- Репозиторій клонований локально

---

## 🚀 Кроки запуску

### 1. Перейти в директорію проєкту

```bash
cd intelligent-autoscaler-clean
```

### 2. Ініціалізувати Terraform
```bash
terraform init
```
Якщо CI — використовуй terraform init -backend=false

### 3. Перевірити формат
```bash
terraform fmt -check
```
### 4. Валідувати конфігурацію
```
bash
terraform validate
```
### 5. Запустити планування
```bash
terraform plan
```
Перевір, чи створюється EC2, VPC, SG, etc.

### 6. Застосувати інфраструктуру
```bash
terraform apply
```
Підтвердити yes — створиться кластер k3s на EC2

## 📍 Перевірка вручну через AWS Console
- EC2 → Instances → перевірити статус

- VPC → Subnets, Security Groups

- IAM → Roles, Policies (якщо є)

- Grafana / k3s → доступ через публічний IP

## 🧠 Поради
- Якщо AMI не працює — перевір вручну через AWS Console → EC2 → AMI → Public images

- Якщо регіон не підтримує тип інстансу — змінити region в main.tf

- Якщо terraform apply падає — запусти terraform destroy і спробуй знову

## 🧹 Очистка
```bash
terraform destroy
```
Видаляє всі ресурси, створені Terraform

## ✅ CI/CD
- .github/workflows/ci.yml перевіряє terraform fmt, validate, kubeconform

- Автоматично запускається при push/pull request

## 📦 Артефакти
- grafana-dashboard.json — метрики autoscaler

- kyverno-hibernation.yaml — policy для хибернації

- adr.md, hld.md, README.md — документація

## 🧠 Автор: Serhii Kyrpotenko
- DevOps/SRE, AWS, Terraform, k3s

- Хакатон: Intelligent Kubernetes Autoscaler Challenge