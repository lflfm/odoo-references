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

start-odoo-with-tests:
	@echo "*--------------------------------------------------------------*"
	@echo "| This will take a LONG time as it will run ALL tests in Odoo  |"
	@echo "| You should only really run this very rarely,                 |"
	@echo "| in very specific scenarios                                   |"
	@echo "| press ctrl+c to abort at any time                            |"
	@echo "*--------------------------------------------------------------*"
	@sleep 7s
	python /odoo/odoo-bin --dev all --test-enable

test-library-app:
	python /odoo/odoo-bin -i library_app -u library_app --dev all --test-tags '/library_app' --stop-after-init

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
	@echo "| WARNING: The local Odoo db will be DELETED                   |"
	@echo "| You may run 'make install-odoo-db' after this for a clean db |"
	@echo "*--------------------------------------------------------------*"
	@sleep 5s
	@.devcontainer/deleteOdooDatabase.sh
	@make install-odoo-db
