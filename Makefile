# Makefile

# Set the shell to bash
SHELL := /bin/bash

# Path to virtualenvwrapper.sh (adjust this to your actual path)
VENVWRAPPER_SCRIPT := /usr/local/bin/virtualenvwrapper.sh

# Name of the virtual environment
VENV = hft

VENV_ACTIVATE=$(WORKON_HOME)/$(VENV)/bin/activate

all: build install

build:
	@echo "Building the Python project..."
	@echo "Setting up virtual environment..."
	# Check if virtual environment already exists
	@if [ ! -d $(WORKON_HOME)/$(VENV) ]; then \
		echo "Creating and activating virtual environment..."; \
		( \
       	   source $(VENVWRAPPER_SCRIPT); \
	   	   mkvirtualenv $(VENV); \
    	); \
	@echo "Installing Python dependencies..."
	. $(VENV_ACTIVATE) && \
	pip install -r requirements.txt && \
	pip install build
	@python -m build

install: 
	@echo "Installing hftbacktest..."
	. $(VENV_ACTIVATE) && \
	pip install --force-reinstall dist/hftbacktest-*.whl

.PHONY: build install
