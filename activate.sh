#!/bin/bash

# Define the deployment file
DEPLOYMENT_FILE="deployment.yaml"

# Step 1: Apply the deployment
echo "Applying the deployment..."
kubectl apply -f $DEPLOYMENT_FILE

# Step 2: Wait for the pod to be ready
echo "Waiting for the pod to be ready..."
POD_NAME=$(kubectl get pods -l app=blackjack -o jsonpath="{.items[0].metadata.name}")
while [[ -z "$POD_NAME" || "$(kubectl get pod $POD_NAME -o jsonpath="{.status.phase}")" != "Running" ]]; do
    sleep 2
    POD_NAME=$(kubectl get pods -l app=blackjack -o jsonpath="{.items[0].metadata.name}")
    echo "Waiting for pod..."
done
echo "Pod is running: $POD_NAME"

# Step 3: Port forward to the pod
echo "Setting up port forwarding to $POD_NAME on port 5003..."
kubectl port-forward $POD_NAME 5003:5003
