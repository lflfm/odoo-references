#!/bin/bash
git config --global --add safe.directory /workspaces
git config --global core.fileMode false
#ideally everyone should sign their commits, but since most people don't, we won't enforce it
#git config --global commit.gpgsign true
sudo chown -R $USER:$USER /workspaces

dos2unix .devcontainer/postStartScript.sh
sudo chmod ug+x /workspaces/.devcontainer/**.sh
.devcontainer/postStartScript.sh

~/installPostgressClient.sh

make install-odoo-db