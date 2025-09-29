Fullstack Application - AWS EKS Deployment
🚀 Project Overview
Fullstack React + Node.js application deployed on AWS EKS with CI/CD pipeline using GitHub Actions.

📋 Architecture
text
Internet → ALB → Kubernetes Ingress → Services → Pods
                    ├── / → frontend-service → Frontend Pods (React)
                    └── /api → backend-svc → Backend Pods (Node.js)
🛠️ Quick Setup
1. EKS Cluster Creation
bash
eksctl create cluster -f cluster-config.yaml
kubectl get nodes
2. Deploy Application
bash
kubectl apply -f k8s/
kubectl get all -n fullstack-app
3. Access URLs
Frontend: http://fullstack-app-alb-740886725.us-east-1.elb.amazonaws.com/

Backend API: http://fullstack-app-alb-740886725.us-east-1.elb.amazonaws.com/api/

📁 Kubernetes Structure
text
k8s/
├── backend-deployment.yaml    # Node.js API (2 replicas)
├── frontend-deployment.yaml   # React app (2 replicas)  
├── services.yaml              # ClusterIP services
├── ingress.yaml               # ALB configuration
├── hpa.yaml                   # Auto-scaling
└── namespace.yaml             # fullstack-app namespace
🔄 CI/CD Pipeline (.github/workflows/deploy.yml)
Automated on push to main branch:

Build & Test - Node.js 18, npm install, run tests

SonarQube Analysis - Code quality checks

Docker Build & Push - Multi-arch images to Docker Hub

EKS Deployment - Automated rollout to Kubernetes

Health Checks - Verify application status

🐳 Docker Images
Frontend: anupsharma329/frontend:latest

Backend: anupsharma329/backend:latest

📊 Monitoring Commands
bash
# Check status
kubectl get all -n fullstack-app

# View logs
kubectl logs -l app=frontend -n fullstack-app --tail=50
kubectl logs -l app=backend -n fullstack-app --tail=50

# Monitor resources
kubectl top pods -n fullstack-app
🚨 Quick Troubleshooting
bash
# Force image update
kubectl rollout restart deployment/frontend-deployment -n fullstack-app
kubectl rollout restart deployment/backend-deployment -n fullstack-app

# Check ALB status
kubectl get ingress -n fullstack-app -w

# Debug pods
kubectl describe pods -n fullstack-app -l app=backend
📈 Features
✅ Auto-scaling (2-5 pods based on CPU)

✅ Load Balancing (AWS ALB)

✅ Zero-downtime deployments

✅ Health checks & readiness probes

✅ Multi-architecture Docker images

✅ SonarQube code quality gates

🔐 Required Secrets (GitHub)
AWS_ACCESS_KEY_ID - AWS credentials

AWS_SECRET_ACCESS_KEY - AWS credentials

DOCKERHUB_USERNAME - Docker Hub access

DOCKERHUB_PASSWORD - Docker Hub access

SONAR_TOKEN - SonarQube analysis

Production URL: http://fullstack-app-alb-740886725.us-east-1.elb.amazonaws.com

Deployed on AWS EKS with full CI/CD automation 🚀

