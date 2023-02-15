.DEFAULT_GOAL := list
.PHONY: 

# This is a makefile for the Odoo devcontainer
# It is essentially a list of commands that can be run to control Odoo
# Most commands here will likely not work at all outside of the devcontainer, mainly because of the paths
# This file can still be used as a reference for commands both in and out of the devcontainer

list:
	@echo "Listing targets"
	@echo "./"
	@cat makefile | grep '\:$$'

start-odoo:
	python /odoo/odoo-bin --dev all

# ex. make test module=rising_api_connector
test:
	@if [ -z "${module}" ]; then echo "Please specify a module to test (eg. make test module=rising_assets_management)"; exit 1; fi
	@echo Testing module ${module}
	python /odoo/odoo-bin -i ${module} -u ${module} --dev all --test-tags '/${module}' --stop-after-init

# Most of the time you just want to run and re-run the tests, use the test command above
# But sometimes, you should make sure you run on a clean DB, to help validate your dependencies and test data
# Of course, you must be careful to only run this in your local dev container, since it deletes the DB!
# ex. make test-clean module=rising_api_connector
test-clean:
	@echo "*--------------------------------------------------------------*"
	@echo "| WARNING: The local Odoo db will be DELETED and recreated     |"
	@echo "*--------------------------------------------------------------*"
	@sleep 5s
	@if [ -z "${module}" ]; then echo "Please specify a module to test (eg. make test module=rising_assets_management)"; exit 1; fi
	@echo Re-creating the DB, then testing module ${module}
	make delete-and-reinstall-odoo-db
	make test

test-all-our-modules:
	@echo "This will test all modules in the /workspace folder"
	@echo "Note that this means it will also install and update all these modules in the current Odoo instance"
	@.devcontainer/testOurModules.sh

run-odoo-in-python-repl:
	python /odoo/odoo-bin shell

install-odoo-db:
	@echo "*--------------------------------------------------------------*"
	@echo "| This is only required if you delete the database             |"
	@echo "| (this is executed automatically when building the container) |"
	@echo "*--------------------------------------------------------------*"
	@sleep 2s
	python /odoo/odoo-bin -i base --stop-after-init
	.devcontainer/prepAndInstallEnterprise.sh

install-odoo-db-community:
	@echo "*-------------------------------------------------------------------*"
	@echo "| This is only required if you delete the database                  |"
	@echo "| Here we will clear enterprise dir and won't attempt to install it |"
	@echo "*-------------------------------------------------------------------*"
	@sleep 2s
	rm -rf /odoo/enterprise-modules/*
	python /odoo/odoo-bin -i base --stop-after-init

delete-odoo-db:
	@echo "*--------------------------------------------------------------*"
	@echo "| WARNING: The local Odoo db will be DELETED                   |"
	@echo "| You may run 'make install-odoo-db' after this for a clean db |"
	@echo "*--------------------------------------------------------------*"
	@sleep 5s
	@.devcontainer/deleteOdooDatabase.sh

delete-and-reinstall-odoo-db:
	@echo "*--------------------------------------------------------------*"
	@echo "| WARNING: The local Odoo db will be DELETED and recreated     |"
	@echo "*--------------------------------------------------------------*"
	@sleep 5s
	@.devcontainer/deleteOdooDatabase.sh
	@make install-odoo-db
