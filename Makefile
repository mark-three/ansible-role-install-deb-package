SHELL := /bin/bash

# Python Variables
VENV_NAME := $(if $(VENV_NAME),$(VENV_NAME),venv)
VENV_PATH := $(if $(VENV_PATH),$(VENV_PATH),./$(VENV_NAME))
VENV_ACT := $(if $(VENV_ACT),$(VENV_ACT),$(VENV_PATH)/bin/activate)


.PHONY: setup
setup:
	# Delete the old VENV if it already exists
	rm -rf $(VENV_PATH)
	# --copies flag copies the Python binaries which enables better support maintaining multiple versions with pyenv
	python -m venv --copies $(VENV_PATH)
	source $(VENV_ACT) && python -m pip install -U pip


.PHONY: setup-pre-commit
setup-pre-commit:
	source $(VENV_ACT) && pre-commit install
	#source $(VENV_ACT) && pre-commit install --hook-type commit-msg --hook-type pre-push
	source $(VENV_ACT) && pre-commit install-hooks


.PHONY: pre-commit
pre-commit:
	source $(VENV_ACT) && pre-commit run --all-files
