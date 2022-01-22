#!/bin/bash

function get_microk8s_token () {

	token=$(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
	microk8s kubectl -n kube-system describe secret ${token}
	# Dashboard on port 8000 by default.
	
}