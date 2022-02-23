.PHONY: help
help:
	@cat $(MAKEFILE_LIST) \
		| grep -e "^[a-zA-Z0-9_\-]*: *.*## *" \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

aks_login: ## login to Azure cli - use to swap environments (prd, dev, uat): make env=uat aks_login
	./scripts/kubectl_login.sh $(env)

azure_login: ## Login the current user to Azure Cli
	az login

jupyter_up: ## Deploy JupyterHub in Azure to AKS: make jupyter_up
	./scripts/jupyterhub/jupyter_up.sh

jupyter_down: ## Remove JupyterHub deployments: make jupyter_down
	./scripts/jupyterhub/jupyter_down.sh

nifi_up: ## Deploy nifi in Azure to AKS: make env=uat nifi_up
	./applications/scripts/nifi/nifi_up.sh $(env)

nifi_down: ## Remove nifi deployments: make env=uat nifi_down
	./applications/scripts/nifi/nifi_down.sh $(env)
