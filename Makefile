.DEFAULT_GOAL := help
.PHONY: help
help: ## Affiche cette aide
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: setup
setup: docker-compose.yml ## Démarre la BD Influxbd et Grafana
	docker-compose -f docker-compose.yml up influxdb grafana

.PHONY: run
run: docker-compose.yml ## Lance les tests de performance sur le fichier entré
	docker-compose -f docker-compose.yml run k6 run /scripts/$(file)
