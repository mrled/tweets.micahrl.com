.POSIX:

# 24737 is BIRDS on a phone keypad
DEVPORT = 24737
DEVHOST = localhost

.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: dev
dev: ## Run the local development server
	hugo mod get
	hugo server \
		--buildDrafts \
		--buildFuture \
		--disableFastRender \
		--bind 0.0.0.0 \
		--baseURL ${DEVHOST} \
		--port ${DEVPORT} \
		--environment development

.PHONY: production
production: ## Build the site in the public/ directory
	hugo mod get
	hugo \
		--cleanDestinationDir \
		--ignoreCache \
		--printPathWarnings \
		$(NETLIFY_BASEURL_ARG)

venv: ## Create the virtual environment
	python3 -m venv venv
	venv/bin/pip install --upgrade pip
	venv/bin/pip install --upgrade twarchive
