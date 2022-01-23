.PHONY: help
help:
	@cat $(MAKEFILE_LIST) \
		| grep -e "^[a-zA-Z0-9_\-]*: *.*## *" \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


dynamodb_up: ## Create DynamoDB table
	./scripts/dynamodb_up.sh

dynamodb_down: ## Destroy Dynamodb table
	./scripts/dynamodb_down.sh

eks_up: ## Create EKS cluster
	./scripts/eks_up.sh

eks_down: ## Destroy EKS cluster
	./scripts/eks_down.sh

elastic_up: ## Create Elasticache cluster
	./scripts/elastic_up.sh

elastic_down: ## Destroy Elasticache cluster
	./scripts/elastic_down.sh

emr_spark_up: ## Create Spark EMR cluster
	./scripts/emr_spark_up.sh

emr_spark_down: ## Destroy Spark EMR cluster
	./scripts/emr_spark_down.sh

k_rs_up: ## Create Kinesis and Redshift
	./scripts/kinesis_redshift_up.sh

k_rs_down: ## Destroy Kinesis and Redshift
	./scripts/kinesis_redshift_down.sh

s3_up: ## Create S3 bucket(s)
	./scripts/s3_up.sh

s3_down: ## Destroy S3 bucket(s)
	./scripts/s3_down.sh