# Do stuff for Gefilte Fish

.PHONY: clean coverage docs help \
	quality requirements test test-all upgrade validate

.DEFAULT_GOAL := help

help: ## display this help message
	@echo "Please use \`make <target>' where <target> is one of"
	@awk -F ':.*?## ' '/^[a-zA-Z]/ && NF==2 {printf "\033[36m  %-25s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

clean: ## remove generated byte code, coverage reports, and build artifacts
	find . -name '__pycache__' -exec rm -rf {} +
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	rm -fr build/
	rm -fr dist/
	rm -fr src/*.egg-info

.PHONY: dist pypi testpypi

dist: ## Build the distributions
	python -m build --sdist --wheel

pypi: ## Upload the built distributions to PyPI.
	python -m twine upload --verbose dist/*

testpypi: ## Upload the distrubutions to PyPI's testing server.
	python -m twine upload --verbose --repository testpypi dist/*
