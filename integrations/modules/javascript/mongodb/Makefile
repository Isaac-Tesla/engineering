.PHONY: help
help:
	@cat $(MAKEFILE_LIST) \
		| grep -e "^[a-zA-Z0-9_\-]*: *.*## *" \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

microk8s_up: ## Install drivers, setup tools, Helm charts and Terraform.
	sudo mongodb/scripts/microk8s_up.sh

microk8s_down: ## Uninstall Microk8s and clean up.
	sudo mongodb/scripts/microk8s_down.sh

mongodb_up: ## Deploy MongoDB. Note: User Robo3T to connect to localhost
	mongodb/scripts/mongodb_up.sh

mongodb_down: ## Uninstall MongoDB.
	mongodb/scripts/mongodb_down.sh

start_dev: ## Run our development server
	npm run devStart