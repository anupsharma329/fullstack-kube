#!/bin/bash
echo "🚀 EKS Deployment Script using existing manifests"

# Update kubeconfig
echo "🔧 Configuring kubectl..."
aws eks update-kubeconfig --region us-east-1 --name fullstack-cluster

# Deploy using existing manifests
echo "📦 Deploying application..."
kubectl apply -f k8s/ --recursive

# Wait for deployment
echo "⏳ Waiting for deployment to complete..."
kubectl rollout status deployment/backend-deployment -n fullstack-app --timeout=300s
kubectl rollout status deployment/frontend-deployment -n fullstack-app --timeout=300s

# Get application URL
LB_URL=$(kubectl get service -n fullstack-app frontend-service -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

echo "🎉 Deployment complete!"
echo "🌐 Frontend: http://$LB_URL"
echo "🔗 Backend API: http://$LB_URL/api/data"
echo "📊 Status:"
kubectl get all -n fullstack-app