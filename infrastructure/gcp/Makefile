.PHONY: help
help:
	@cat $(MAKEFILE_LIST) \
		| grep -e "^[a-zA-Z0-9_\-]*: *.*## *" \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

init: ## Setup the GCP Cli tool
	sudo ./scripts/init_gcp.sh

init_helm: ## Setup Helm
	sudo ./scripts/init_helm.sh

init_terraform: ## Setup Terraform
	sudo ./scripts/init_terraform.sh