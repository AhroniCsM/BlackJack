Aharon Blackjack - Kubernetes Deployment with OpenTelemetry

This repository contains a Flask-based Blackjack application with OpenTelemetry auto-instrumentation configured.
The project is deployed on Kubernetes, and the instructions below describe the deployment and port forwarding process.

You can use the provided Activate.sh script to automate deployment and port forwarding.

Run the Script:
chmod +x activate.sh
bash activate.sh

The script will:

- Deploy the application to Kubernetes.

- Wait for the pod to be ready.

- Set up port forwarding to localhost:5003.

4. Access the Application

Once port forwarding is set up, access the application at:

http://localhost:5003
