.PHONY: help
help:
	@cat $(MAKEFILE_LIST) \
		| grep -e "^[a-zA-Z0-9_\-]*: *.*## *" \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

init_ansible: ## Install Ansible control node
	./init_ansible.sh

init_aws: ## Setup AWS Cli
	./init_aws.sh

init_azure: ## Setup Azure Cli. Include subscription. e.g. make sub=<subscriptionId> init_azure
	./init_azure.sh $(sub)

init_conda: ## Install Anaconda for Python
	./init_anaconda.sh

init_cuda: ## Setup CUDA and Tensorflow-GPU
	./init_cuda.sh

init_docker: ## Install Docker and Docker-Compose
	./init_docker.sh

init_flutter: ## Setup Flutter
	./init_flutter.sh

init_gcp: ## Setup GCP
	./init_gcp.sh

init_java: ## Install Java
	./init_java.sh

init_helm: ## Setup Helm
	./init_helm.sh

init_net: ## Install .NET for C#.
	./init_.net.sh

init_nodejs: ## Install NodeJS
	./init_nodejs.sh

init_mssql: ## Install MSSQL drivers
	./init_mssql_drivers.sh

init_r: ## Install R and RStudio
	./init_r.sh

init_tf: ## Setup Terraform
	./init_terraform.sh

init_ubuntu: ## Setup Ubuntu
	./init_ubuntu.sh