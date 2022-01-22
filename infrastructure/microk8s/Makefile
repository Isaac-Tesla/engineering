.PHONY: help
help:
	@cat $(MAKEFILE_LIST) \
		| grep -e "^[a-zA-Z0-9_\-]*: *.*## *" \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

airflow_up: ## Deploy the Airflow Helm chart.
	scripts/airflow_up.sh

airflow_down: ## Uninstall the Airflow Helm chart.
	scripts/airflow_down.sh

kafka_up: ## Deploy the Kafka chart.
	scripts/kafka_up.sh

kafka_down: ## Uninstall the Kafka chart.
	scripts/kafka_down.sh

metabase_up: ## Deploy the Metabase chart.
	scripts/metabase_up.sh

metabase_down: ## Uninstall the Metabase chart.
	scripts/metabase_down.sh

microk8s_up: ## Install drivers, setup tools, Helm charts and Terraform.
	sudo scripts/microk8s_up.sh

microk8s_down: ## Uninstall Microk8s and clean up.
	sudo scripts/microk8s_down.sh

mongodb_up: ## Deploy MongoDB. Note: User Robo3T to connect to localhost
	scripts/mongodb_up.sh

mongodb_down: ## Uninstall MongoDB.
	scripts/mongodb_down.sh

postgresql_up: ## Deploy the Postgresql Helm chart.
	scripts/postgresql_up.sh

postgresql_down: ## Uninstall the Postgresql Helm chart.
	scripts/postgresql_down.sh

spark_setup: ## Add the docker image to Microk8s registry
	scripts/spark_kubernetes_setup.sh

spark_client_setup: ## Install Spark on local machine for client/driver.
	scripts/spark_kubernetes_client_setup.sh

superset_up: ## Deploy the Helm chart.
	scripts/superset_up.sh

superset_down: ## Uninstall the Helm chart.
	scripts/superset_down.sh
