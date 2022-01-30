.PHONY: help
help:
	@cat $(MAKEFILE_LIST) \
		| grep -e "^[a-zA-Z0-9_\-]*: *.*## *" \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


azure_login: ## Login the current user to Azure Cli
	az login

nifi_up: ## Deploy nifi in Azure to AKS: make env=dev nifi_up
	./applications/scripts/nifi/nifi_up.sh $(env)

nifi_down: ## Remove nifi deployments: make env=dev nifi_down
	./applications/scripts/nifi/nifi_down.sh $(env)
