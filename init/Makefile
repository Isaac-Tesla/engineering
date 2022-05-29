.PHONY: help
help:
	@cat $(MAKEFILE_LIST) \
		| grep -e "^[a-zA-Z0-9_\-]*: *.*## *" \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

aws: ## Setup AWS Cli
	sudo ./init_aws.sh

azure: ## Setup Azure Cli. Include subscription. e.g. make sub=<subscriptionId> init_azure
	./init_azure.sh $(sub)

conda: ## Install Anaconda for Python
	./init_conda.sh

cpp: ## Install C++ compiler
	./init_cpp.sh

cuda: ## Setup CUDA and Tensorflow-GPU
	./init_cuda.sh

docker: ## Install Docker and Docker-Compose
	./init_docker.sh

flutter: ## Setup Flutter
	./init_flutter.sh

gcp: ## Setup GCP
	./init_gcp.sh

go: ## Setup Go Lang
	./init_golang.sh

helm: ## Setup Helm
	./init_helm.sh

java: ## Install Java
	./init_java.sh

kubectl: ## Install kubectl for Kubernetes.
	./init_kubectl.sh

mssql: ## Install MSSQL drivers
	./init_mssql_drivers.sh

net: ## Install .NET for C#.
	sudo ./init_net.sh

nodejs: ## Install NodeJS
	./init_nodejs.sh

pwsh: ## Install Powershell
	./init_powershell.sh

python: ## Install Python pip and some core packages
	./init_python.sh

r: ## Install R and RStudio
	./init_r.sh

ruby: ## Install Ruby
	./init_ruby.sh

scala: ## Install Scala
	./init_scala.sh

spark: ## Install Spark
	./init_spark.sh

tf: ## Setup Terraform
	./init_terraform.sh

ubuntu: ## Setup Ubuntu
	./init_ubuntu.sh

wine: ## Setup Wine
	./init_wine.sh