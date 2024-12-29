Aharon Black - Kubernetes Deployment with OpenTelemetry

This repository contains a Flask-based Blackjack application with OpenTelemetry auto-instrumentation configured. The project is deployed on Kubernetes, and the instructions below describe the deployment and port forwarding process.

Prerequisites

Ensure you have the following tools installed:

Docker

Kubernetes CLI (kubectl)

AWS CLI (configured for ECR access)

A Kubernetes cluster

Steps to Deploy and Run the Application


 Automate Deployment and Port Forwarding

You can use the provided Activate.sh script to automate deployment and port forwarding.

Run the Script:
chmod +x activate.sh
bash activate.sh

The script will:

Deploy the application to Kubernetes.

Wait for the pod to be ready.

Set up port forwarding to localhost:5003.

4. Access the Application

Once port forwarding is set up, access the application at:

http://localhost:5003

Environment Variables

The deployment uses the following OpenTelemetry environment variables:

OTEL_IP: The host IP of the node where the pod is running.

OTEL_SERVICE_NAME: Set to blackjack.

OTEL_RESOURCE_ATTRIBUTES: Includes metadata about the application and subsystem.

OTEL_EXPORTER_OTLP_ENDPOINT: Sends traces to the OTLP endpoint.