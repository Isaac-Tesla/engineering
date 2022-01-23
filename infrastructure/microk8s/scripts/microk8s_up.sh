#!/bin/bash

<<COMMENT

  Summary:
  The following code will install Microk8s and enable:
  - helm3
  - istio
  - dns, dashboard, storage, registry, rbac
  - kubeflow

  The official setup instructions can be found on the 
    microk8s website here: https://microk8s.io/docs

COMMENT


sudo snap install microk8s --classic --channel=1.21/stable

# Add the current user to the group, and reload the group
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
newgrp microk8s

# Run the following to fix calico IPv4 issue.
microk8s kubectl set env daemonset/calico-node -n kube-system IP_AUTODETECTION_METHOD=interface=eth.*,en.*,em.*,wl.*

# Start it up
microk8s start

# Enable what we want to use. For a list run -> microk8s status
microk8s enable dns dashboard storage registry rbac
microk8s enable helm3
microk8s enable istio

# Add the extra dashboard service - dashboard on port 30000
microk8s kubectl apply -f ./mk8s/svc_dashboard.yaml --namespace=kube-system

# Copy the kubeconfig to make it easier to login - /var/snap/microk8s/current/credentials/client.config 
cp /var/snap/microk8s/current/credentials/client.config ~/

# Only enable kubeflow once everything else is running or it will fail.
microk8s enable kubeflow

# Check everything
microk8s kubectl get pods --all-namespaces
microk8s kubectl get svc -n kubeflow