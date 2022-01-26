.PHONY: help
help:
	@cat $(MAKEFILE_LIST) \
		| grep -e "^[a-zA-Z0-9_\-]*: *.*## *" \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

bigquery_up: ## Setup a BigQuery instance.
	sudo ./scripts/bigquery_up.sh

bigquery_down: ## Remove a BigQuery instance.
	sudo ./scripts/bigquery_down.sh
