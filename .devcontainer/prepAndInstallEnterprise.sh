#!/bin/bash

# we will create this dir anyway because our odoo is configured to look for modules in there
mkdir -p /odoo/enterprise-modules

# check that there is a zip file with current Odoo version
if [ ! -f /workspaces/.enterprise/enterprise-${ODOOVERSION}.zip ]; then
    echo "No enterprise zip file found."
    exit 0
fi
#unzip enterprise zip file
mkdir -p /tmp/enterprise-modules
rm -rf /odoo/enterprise-modules/*
unzip /workspaces/.enterprise/enterprise-${ODOOVERSION}.zip -d /tmp/enterprise-modules
mv /tmp/enterprise-modules/enterprise-${ODOOVERSION}/* /odoo/enterprise-modules
rm -rf /tmp/enterprise-modules

# install enterprise web module
python /odoo/odoo-bin -i web_enterprise --stop-after-init