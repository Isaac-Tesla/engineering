#!/bin/bash

function install_microk8s () {

   # Official instructions
   # https://microk8s.io/docs

   sudo snap install microk8s --classic --channel=1.21/stable

   # Add the current user to the group
   sudo usermod -a -G microk8s $USER
   sudo chown -f -R $USER ~/.kube

	# Following to fix calico IPv4 issue.
	microk8s kubectl set env daemonset/calico-node -n kube-system IP_AUTODETECTION_METHOD=interface=eth.*,en.*,em.*,wl.*
	microk8s enable dns dashboard storage

	# Docker registry instructions - https://microk8s.io/docs/registry-built-in
	microk8s enable registry
	microk8s enable helm3

   # Start it up
   microk8s start
   
   # Add the extra dashboard service
   microk8s kubectl apply -f ./k8s/svc_dashboard.yaml --namespace=kube-system

   # Check everything 
   microk8s kubectl get pods --all-namespaces

   # Potential location for your kubeconfig - /var/snap/microk8s/current/credentials/client.config 

}